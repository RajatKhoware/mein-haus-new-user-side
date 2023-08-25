// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/features/chat/widgets/chat_textfield.dart';
import 'package:new_user_side/features/chat/widgets/customer_end_conversation_bottom_sheet.dart';
import 'package:new_user_side/features/chat/widgets/support_chat_appbar.dart';
import 'package:new_user_side/features/customer%20support/widget/show_flagged_query.dart';
import 'package:new_user_side/provider/notifiers/chat_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_with_pro_notifier.dart';
import 'package:new_user_side/static%20components/dialogs/customer_close_ticket_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../data/network/network_api_servcies.dart';
import '../../../provider/notifiers/auth_notifier.dart';
import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../provider/notifiers/support_notifier.dart';
import '../widgets/chat_no_message_yet.dart';
import '../widgets/chat_project_details_block.dart';
import '../widgets/pro_chat_appbar.dart';
import '../widgets/recived_message.dart';
import '../widgets/sent_message.dart';

class ChattingScreen extends StatefulWidget {
  static const String routeName = '/chattingScreen';
  const ChattingScreen({
    Key? key,
    required this.isChatWithPro,
    this.sendUserId,
    this.conversations,
    required this.estimateId,
  }) : super(key: key);
  final bool isChatWithPro;
  final int? sendUserId;
  final String estimateId;
  final Conversations? conversations;

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late ChatNotifier notifier;
  @override
  void initState() {
    super.initState();
    loadMessages();
    showQueryCloseDailog();
    updateConversationList();
  }

  @override
  void didChangeDependencies() {
    notifier = context.read<ChatNotifier>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    notifier.myMessaage.messages!.clear();
    widget.isChatWithPro ? null : notifier.unsubscribe();
  }

// pusher channel setup
  Future setupPusherChannel() async {
    final notifier = context.read<ChatNotifier>();
    if (!widget.isChatWithPro) {
      await notifier.setupPusher(context);
    }
  }

// clearing the saved messages
  void clearMessage() {
    final notifier = context.read<ChatNotifier>();
    notifier.myMessaage.messages!.clear();
  }

// load messages
  Future loadMessages() async {
    final notifier = context.read<ChatNotifier>();
    final ticketId = context.read<SupportNotifier>().ticketId;
    MapSS body = widget.isChatWithPro
        ? {
            "to_user_id": widget.sendUserId.toString(),
            "estimate_service_id": widget.estimateId,
          }
        : {
            "ticket_id": ticketId,
            "estimate_service_id": widget.estimateId,
          };
    await notifier.loadMessages(context: context, body: body);
  }

  // show close query dialog
  void showQueryCloseDailog() {
    final supportNotifier = context.read<SupportNotifier>();
    if (!widget.isChatWithPro && supportNotifier.showClosingDialog) {
      Timer(
        const Duration(seconds: 1),
        () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const CustosmerCloseTicketDialog();
            },
          );
        },
      );
    }
  }

  // Update the all conversation list
  Future<void> updateConversationList() async {
    final proChatNotifier = context.read<ChatWithProNotifier>();
    await proChatNotifier.allConversation(context);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatNotifier>();
    final userNotifier = context.read<AuthNotifier>().user;
    final projectNotifier = context.read<EstimateNotifier>();
    final supportNotifier = context.watch<SupportNotifier>();
    final projectDeatils = projectNotifier.projectDetails.services;
    final h = context.screenHeight;
    final w = context.screenWidth;

    return notifier.myMessaage.messages != null
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              // App bar
              appBar: PreferredSize(
                preferredSize: Size(w, h / 14),
                child: widget.isChatWithPro
                    ? ProChatAppBar(
                        senderImg: widget.conversations!.profilePicture!,
                        senderName: widget.conversations!.toUserName!,
                      )
                    : SupportChatAppbar(),
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      // Showing project details here
                      widget.isChatWithPro
                          ? ProjectDetailsBlock(
                              projectNmae: widget.conversations!.projectName,
                              projectId:
                                  widget.conversations!.estimateBookingId,
                              projectStartedDate:
                                  widget.conversations!.projectStartedOn,
                            )
                          : ProjectDetailsBlock(
                              projectNmae: projectDeatils!.projectName,
                              projectId: projectDeatils.estimateNo,
                              projectStartedDate:
                                  projectDeatils.projectStartDate,
                            ),
                      // Showing all the message below
                      notifier.myMessaage.messages!.length > 0
                          ? Expanded(
                              child: NotificationListener<ScrollNotification>(
                                onNotification: (scrollNotification) {
                                  if (scrollNotification
                                      is ScrollEndNotification) {
                                    if (notifier
                                            .scrollController.position.pixels ==
                                        notifier.scrollController.position
                                            .minScrollExtent) {
                                      notifier.loadMoreMessages(context);
                                    }
                                  }
                                  return false;
                                },
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  controller: notifier.scrollController,
                                  child: ListView.builder(
                                    controller: notifier.scrollController,
                                    padding: EdgeInsets.only(bottom: h / 10),
                                    itemCount:
                                        notifier.myMessaage.messages!.length,
                                    itemBuilder: (context, index) {
                                      final messages = notifier.myMessaage;
                                      final message = messages.messages![index];
                                      if (widget.isChatWithPro
                                          ? message.senderId ==
                                              widget.sendUserId
                                          : message.senderId !=
                                              userNotifier.userId) {
                                        return RecivedMessage(
                                          message: message,
                                          senderImg: widget
                                              .conversations!.profilePicture!,
                                        );
                                      } else {
                                        return SendMessage(
                                          message: message,
                                          isConvoEnd: false,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          : NoMessageYetWidget(),
                    ],
                  ),
                  // load more message loading indicator
                  Positioned(
                    left: w / 2.2,
                    top: h / 12,
                    child: notifier.loadMoreLoading
                        ? LoadingAnimationWidget.bouncingBall(
                            color: AppColors.black,
                            size: w / 20,
                          )
                        : SizedBox(),
                  ),
                  // message text field
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: supportNotifier.isQueryFlagged
                        ? ShowQueryIsFlagged()
                        : supportNotifier.isQuerySolved
                            ? CustomerEndConvoBottomSheet()
                            : ChatTextField(),
                  ),
                ],
              ),
            ),
          )
        : ModalProgressHUD(inAsyncCall: true, child: Scaffold());
  }
}
