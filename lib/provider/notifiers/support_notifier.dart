import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/data/pusher_services.dart';
import 'package:new_user_side/provider/notifiers/chat_notifier.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/repository/customer_support_repo.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../data/models/message_model.dart';
import '../../data/models/raised_query_model.dart';
import '../../local db/user_prefrences.dart';
import '../../resources/common/my_snake_bar.dart';

class SupportNotifier extends ChangeNotifier {
  PusherService _pusherService = PusherService.instance;
  TextEditingController messageController = TextEditingController();
  CustomerSupportRepo repo = CustomerSupportRepo();

  // VARIABLES
  bool _loading = false;
  List<XFile> _images = [];
  RaisedQueryModel _queryModel = RaisedQueryModel();
  int _supportStatus = 0;
  String _ticketId = "";
  bool _showClosingDialog = false;
  bool _isQuerySolved = false;
  bool _isQueryFlagged = false;

  // GETTERS
  bool get loading => _loading;
  List<XFile> get images => _images;
  RaisedQueryModel get queryModel => _queryModel;
  int get supportStatus => _supportStatus;
  String get ticketId => _ticketId;
  bool get showClosingDialog => _showClosingDialog;
  bool get isQuerySolved => _isQuerySolved;
  bool get isQueryFlagged => _isQueryFlagged;

  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void setImagesInList(List<XFile> images) {
    _images = images;
    notifyListeners();
  }

  void removeImageFromList(XFile pickedFile) {
    _images.remove(pickedFile);
    notifyListeners();
  }

  void setQueryModel(RaisedQueryModel query) {
    _queryModel = query;
    notifyListeners();
  }

  setSupportStatus(int status) {
    _supportStatus = status;
    notifyListeners();
  }

  void setShowClosingDialog(bool status) {
    _showClosingDialog = status;
    notifyListeners();
  }

  setTicketId(String ticketId) {
    _ticketId = ticketId;
    notifyListeners();
  }

  void setIsQuerySoved(bool state) {
    _isQuerySolved = state;
    notifyListeners();
  }

  void setIsQueryFlagged(bool state) {
    _isQueryFlagged = state;
    notifyListeners();
  }

  /// Setup Pusher channel
  Future setupPusher(BuildContext context, List channelNames) async {
    await _pusherService
        .setupPusherConnection(context, channelNames)
        .then((value) {
      ("Pusher setup done").log("Pusher");
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
      ("Erorr in setup pusher --> $error").log("Pro-Chat Notifier");
    });
  }

  // Unsubscribe pusher channel
  void unsubscribe(String projectId) async {
    final userId = await UserPrefrences().getUserId();
    String channelName = "private-query.$projectId.$userId";
    _pusherService.pusher.unsubscribe(channelName: channelName);
    ("Channel Unsunscribed $channelName").log("Pusher");
  }

  // Send Query to support
  Future sendQuery({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    setLoadingState(true, true);
    await repo.sendQuery(body).then((response) {
      setLoadingState(false, true);
      setImagesInList([]);
      showSnakeBarr(
          context, response["response_message"], SnackBarState.Success);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      ("${error} $stackTrace").log("Send Query notifier");
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
    });
  }

  // Get Raised Query
  Future getRaisedQuery({
    required BuildContext context,
    required String id,
  }) async {
    repo.getRaisedQuery(id).then((response) {
      var data = RaisedQueryModel.fromJson(response);
      setQueryModel(data);
      ('Get Raised Query ✅').log();
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Get Raised Query notifier");
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
    });
  }

  // Keep open support chat
  Future keepOpen(BuildContext context) async {
    final chatNotifier = context.read<ChatNotifier>();
    final supportNotifier = context.read<SupportNotifier>();
    final conversationId = chatNotifier.myMessaage.conversationId;
    final ticketId = supportNotifier.ticketId;
    MapSS body = {
      "conversation_id": conversationId.toString(),
      "ticket_id": ticketId,
      "message": messageController.text,
    };
    setLoadingState(true, true);
    await repo.keepOpen(body).then((response) {
      setLoadingState(false, true);
      final data = MessageModel.fromJson(response);
      for (var message in data.messages!) {
        chatNotifier.updateOrAddNewMessage(message);
      }
      setIsQuerySoved(false);
      setShowClosingDialog(false);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
      ("Erorr in keep open --> $error").log("Support Notifier");
      setLoadingState(false, true);
    });
  }

  // Accept and close support chat
  Future acceptAndClose(BuildContext context) async {
    final chatNotifier = context.read<ChatNotifier>();
    final conversationId = chatNotifier.myMessaage.conversationId;
   
    MapSS body = {
      "conversation_id": conversationId.toString(),
      "ticket_id": ticketId,
    };
    setLoadingState(true, true);
    await repo.acceptAndClose(body).then((response) {
      setLoadingState(false, true);
      setIsQuerySoved(true);
      setSupportStatus(0);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
      ("Erorr in accept and close --> $error").log("Support Notifier");
      setLoadingState(false, true);
    });
  }
}
