import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/message_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/data/pusher_services.dart';
import 'package:new_user_side/local%20db/user_prefrences.dart';
import 'package:new_user_side/repository/chat_respository.dart';
import 'package:new_user_side/resources/loading/loading_screen.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../error_screens.dart';
import '../../resources/common/my_snake_bar.dart';
import 'auth_notifier.dart';

class ChatNotifier extends ChangeNotifier {
  ChatRepository repo = ChatRepository();
  final loadingScreen = LoadingScreen.instance();
  PusherService _pusherService = PusherService.instance;
  TextEditingController messageController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    _message.messages!.clear();
    super.dispose();
  }

  // VARIABLES
  bool _loading = false;
  bool _loadMoreLoading = false;
  int _pageNo = 1;

  double _scrollPostion = 0;
  String _lastMessage = '';
  List<XFile> _images = [];
  XFile _image = XFile("");
  MessageModel _message = MessageModel();

  // GETTERS
  bool get loading => _loading;
  bool get loadMoreLoading => _loadMoreLoading;
  List<XFile> get images => _images;
  XFile get image => _image;
  MessageModel get myMessaage => _message;

  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void setLoadMoreLoading(bool state, bool notify) {
    _loadMoreLoading = state;
    if (notify) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void setMessages(MessageModel messages) {
    _message = messages;
    notifyListeners();
  }

  void setImagesInList(List<XFile> images) {
    _images = images;
    notifyListeners();
  }

  void setImage(XFile image) {
    _image = image;
    notifyListeners();
  }

  void setPageNo({int? pageNo}) {
    if (pageNo != null) {
      _pageNo = pageNo;
    } else {
      _pageNo++;
    }
    notifyListeners();
  }

  void setScrollPostion(double newPosition) {
    _scrollPostion = newPosition;
    notifyListeners();
  }

  void setLastMessage(String text) {
    _lastMessage = text;
    notifyListeners();
  }

  void _scrollToBottom() {
    if (_message.messages!.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void _loadMoreScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent - _scrollPostion,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
  }

  void updateOrAddNewMessage(Messages messages) {
    final existingMessageIndex = _message.messages!.indexWhere(
      (m) => m.id == messages.id,
    );
    if (existingMessageIndex >= 0) {
      _message.messages![existingMessageIndex] = messages;
    } else {
      _message.messages!.add(messages);
    }
    notifyListeners();
    _scrollToBottom();
  }

  void unsubscribe() async {
    final userId = await UserPrefrences().getUserId();
    String channelName = "private-chat.$userId";
    _pusherService.pusher.unsubscribe(channelName: channelName);
    ("Channel Unsunscribed $channelName").log("Pusher");
  }

  void onErrorHandler(
    BuildContext context,
    Object? error,
    StackTrace stackTrace,
  ) {
    showSnakeBarr(context, "$error", SnackBarState.Error);
    ("$error $stackTrace").log("Chat notifier");
    Navigator.of(context).pushScreen(ShowError(error: error.toString()));
  }

  /// Setup Pusher channel
  Future setupPusher(BuildContext context) async {
    final userNotifier = context.read<AuthNotifier>().user;
    final userId = userNotifier.userId.toString();
    final channelName = ["private-chat.$userId"];
    await _pusherService
        .setupPusherConnection(context, channelName)
        .then((value) {
      ("Pusher setup done").log("Pusher");
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
    });
  }

  /// Loads messages based on the provided `body` data.
  Future loadMessages({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repo.loadMessages(body).then((response) {
      final data = MessageModel.fromJson(response);
      setMessages(data);
      setPageNo(pageNo: 1);
      setLoadingState(false, true);
      _scrollToBottom();
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
      setLoadingState(false, true);
    });
  }

  /// Send Messages [ Texts/Images ]
  Future sendMessage({required BuildContext context}) async {
    // if message is type of img we dont set a dummmy message on ui
    image.path.isEmpty ? sendDummyMessage(context) : setLastMessage("");
    // getting img if there is any
    final imgPath = await Utils.convertToMultipartFile(image);
    final body = {
      "message": _lastMessage,
      "conversation_id": _message.conversationId.toString(),
      "files[]": imgPath,
    };
    await repo.sendMessage(body).then((response) {
      final data = MessageModel.fromJson(response);
      updateOrAddNewMessage(data.messages!.first);
      setImage(XFile(""));
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
    });
  }

  /// Send Pdf
  Future sendPdf({
    required BuildContext context,
    required MultipartFile file,
  }) async {
    Map<String, dynamic> body = {
      "conversation_id": _message.conversationId.toString(),
      "files[]": file,
    };
    await repo.sendMessage(body).then((response) {
      final data = MessageModel.fromJson(response);
      for (var message in data.messages!) {
        updateOrAddNewMessage(message);
      }
    }).onError((error, stackTrace) {
      onErrorHandler(context, error, stackTrace);
    });
  }

  /// Send Dummy Message Before calling the api and getting the response
  sendDummyMessage(BuildContext context) {
    // Add a new message
    final userNotifier = context.read<AuthNotifier>().user;
    final userId = userNotifier.userId;
    int largestId = 0;
    for (var message in myMessaage.messages!) {
      int messageId = message.id!;
      if (messageId > largestId) {
        largestId = messageId;
      }
    }
    final message = Messages(
      id: largestId + 1,
      senderId: userId,
      isSeen: 0,
      forwarded: 0,
      message: messageController.text,
      createdAt: DateTime.now().toString(),
      type: "text",
    );
    updateOrAddNewMessage(message);
    setLastMessage(messageController.text);
    messageController.clear();
  }

  /// Load 20 more messages every time we hit this api
  Future loadMoreMessages(BuildContext context) async {
    setLoadMoreLoading(true, true);
    MapSS body = {
      "conversation_id": _message.conversationId.toString(),
      "paginateVar": _pageNo.toString(),
    };
    if (_message.messageCount != _message.messages!.length) {
      await repo.loadMoreMessages(body).then((response) {
        final data = MessageModel.fromJson(response);
        _message.messages!.insertAll(0, data.messages!);
        setPageNo();
        setScrollPostion(scrollController.position.maxScrollExtent);
        _loadMoreScroll();
        setLoadMoreLoading(false, true);
      }).onError((error, stackTrace) {
        setLoadMoreLoading(false, true);
        onErrorHandler(context, error, stackTrace);
      });
    } else {
      setLoadMoreLoading(false, true);
    }
  }

  /// Read messages
  Future readMessage(MapSS body) async {
    if (myMessaage.messages != null && myMessaage.messages!.isNotEmpty)
      repo.readMessage(body).then((value) {
        print("messages readed by sender");
      }).onError((error, stackTrace) {
        ("Erorr in Read Message --> $error").log("Pro-Chat Notifier");
      });
  }
}
