// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/features/chat/screen/chatting_screen.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_with_pro_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/utils.dart';
import 'package:provider/provider.dart';

class AllConversationScreen extends StatefulWidget {
  static const String routeName = '/chatList';
  const AllConversationScreen({super.key});

  @override
  State<AllConversationScreen> createState() => _AllConversationScreenState();
}

class _AllConversationScreenState extends State<AllConversationScreen> {
  @override
  void initState() {
    super.initState();
    getAllConversation();
  }

  // AllConversation
  Future<void> getAllConversation() async {
    final notifier = context.read<ChatWithProNotifier>();
    await notifier.allConversation(context);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatWithProNotifier>();
    final conversationList = notifier.conversationsList;
    final conversations = conversationList.conversations;

    return ModalProgressHUD(
      inAsyncCall: notifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Messages"),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: conversations!.length,
                itemBuilder: (context, index) {
                  return ChatCardWidget(
                    conversations: conversations[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatCardWidget extends StatelessWidget {
  final Conversations conversations;

  const ChatCardWidget({
    Key? key,
    required this.conversations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userNotifier = context.read<AuthNotifier>().user;
    final h = context.screenHeight;
    final w = context.screenWidth;
    final conv = conversations;
    int? toUserId = conv.toUserId;
    bool? isSendByPro = true;

// checking if message is from my side or from pro side
    if (userNotifier.userId == conv.toUserId) {
      toUserId = conv.fromUserId;
      isSendByPro = false;
    }

    void loadMessages() {
      Navigator.of(context).pushScreen(
        ChattingScreen(
          isChatWithPro: true,
          sendUserId: toUserId!,
          conversations: conv,
          estimateId: conv.estimateServiceId.toString(),
        ),
      );
    }

    return InkWell(
      onTap: () => loadMessages(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w / 40, vertical: h / 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // profile pic, projectname, username, message
            Row(
              children: [
                // profile pic
                CircleAvatar(
                  radius: w / 14,
                  backgroundImage: conv.profilePicture!.isEmpty
                      ? AssetImage("assets/images/face/man_1.png")
                      : NetworkImage(conv.profilePicture!)
                          as ImageProvider<Object>,
                ),
                SizedBox(width: w / 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h / 200),
                    // projectname
                    SizedBox(
                      width: w / 1.8,
                      child: MyTextPoppines(
                        text: conv.projectName!,
                        fontSize: w / 28,
                        color: AppColors.buttonBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: h / 160),
                    // username
                    MyTextPoppines(
                      text: conv.toUserName!,
                      fontSize: w / 32,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: h / 300),
                    // message
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isSendByPro
                            ? MyTextPoppines(
                                text: "You :  ",
                                fontSize: w / 40,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: isSendByPro ? w / 1.9 : w / 1.6,
                          child: mType(
                            conv.lastMessageType!,
                            context,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // text time, unreaded count
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: h / 120),
                    // text time
                    MyTextPoppines(
                      text: Utils.getTimeAgo(conv.lastMessageCreatedAt!),
                      fontSize: w / 45,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: h / 120),
                    // unreaded count
                    conv.unreadCount! == 0
                        ? const SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w / 20),
                              color: AppColors.yellow,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: w / 50, vertical: h / 300),
                            child: MyTextPoppines(
                              text: conv.unreadCount.toString(),
                              fontSize: w / 45,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget mType(String messageType, BuildContext context) {
    final w = context.screenWidth;
    final textMessage = MyTextPoppines(
      text: conversations.lastMessage!,
      fontSize: w / 40,
      maxLines: 1,
      height: 1.4,
      color: conversations.unreadCount! == 0
          ? AppColors.black.withOpacity(0.5)
          : AppColors.black.withOpacity(0.8),
      fontWeight: FontWeight.w500,
    );
    final pdfMessage = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.picture_as_pdf,
          size: w / 26,
          color: AppColors.grey,
        ),
        MyTextPoppines(
          text: "  Pdf",
          fontSize: w / 40,
          maxLines: 1,
          height: 1.4,
          color: conversations.unreadCount! == 0
              ? AppColors.black.withOpacity(0.5)
              : AppColors.black.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
    final imgMessage = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.picture_as_pdf,
          size: w / 26,
          color: AppColors.grey,
        ),
        MyTextPoppines(
          text: "  Photo",
          fontSize: w / 36,
          maxLines: 1,
          height: 1.4,
          color: conversations.unreadCount! == 0
              ? AppColors.black.withOpacity(0.5)
              : AppColors.black.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
    switch (messageType) {
      case "text":
        return textMessage;
      case "pdf":
        return pdfMessage;
      case "png":
        return imgMessage;
      case "jpg":
        return imgMessage;
      default:
        return textMessage;
    }
  }
}
