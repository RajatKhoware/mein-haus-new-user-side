import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_user_side/data/models/message_model.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/download_files/download_file.dart';
import '../../../utils/utils.dart';
import 'preview_chat_images.dart';

// SEND MESSAGES
class SendMessage extends StatelessWidget {
  final bool? isConvoEnd;
  final Messages message;
  const SendMessage({
    Key? key,
    this.isConvoEnd = false,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final createdAt = message.createdAt.toString();
    final messageTime = Utils.convertToRailwayTime(createdAt);
    return Container(
      margin: EdgeInsets.only(
        left: w / 4,
        top: h / 80,
        bottom: h / 80,
        right: w / 80,
      ),
      padding: EdgeInsets.symmetric(horizontal: w / 28, vertical: h / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(w / 20),
          topRight: Radius.circular(w / 20),
          bottomLeft: Radius.circular(w / 20),
        ),
        color: isConvoEnd!
            ? AppColors.yellow.withOpacity(0.12)
            : const Color(0xFF22577A).withOpacity(0.7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (message.message!.contains("Reason for denying"))
            SizedBox(
              width: w / 1.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextPoppines(
                    text: "Reason for denying : ",
                    fontSize: w / 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    maxLines: 100,
                  ),
                  SizedBox(height: h / 200),
                  MyTextPoppines(
                    text: message.message!,
                    fontSize: w / 32,
                    fontWeight: FontWeight.w500,
                    color: isConvoEnd! ? AppColors.black : AppColors.white,
                    maxLines: 100,
                  ),
                ],
              ),
            )
          else
            ChatHelper.showMessage(
              context: context,
              messageType: message.type ?? "text",
              message: message.message ?? "",
              messageColor: isConvoEnd! ? AppColors.black : AppColors.white,
            ),
          MyTextPoppines(
            text: messageTime,
            fontSize: w / 32,
            fontWeight: FontWeight.w500,
            color: isConvoEnd!
                ? AppColors.black.withOpacity(0.6)
                : AppColors.white.withOpacity(0.6),
            maxLines: 20,
          ),
          Icon(
            ChatHelper.setIcon(message.isSeen ?? 0),
            size: w / 25,
            color: ChatHelper.setIconColor(message.isSeen ?? 0),
          )
        ],
      ),
    );
  }
}

class ChatHelper {
  // Showing messages according to there type
  static Widget showMessage({
    required BuildContext context,
    required String messageType,
    required String message,
    required Color messageColor,
  }) {
    final w = context.screenWidth;
    final textMessage = SizedBox(
      width: w / 1.9,
      child: MyTextPoppines(
        text: message,
        fontSize: w / 32,
        fontWeight: FontWeight.w500,
        color: messageColor,
        maxLines: 100,
      ),
    );
    final pdfMessage = DownloadFile(fileNmae: message);
    final imgMessage = SizedBox(
      width: w / 1.9,
      child: InkWell(
        onTap: () => Navigator.of(context).pushScreen(
          PreviewChatImages(imgPath: message),
        ),
        child: Hero(
          tag: message,
          child: CachedNetworkImage(
            imageUrl: message,
            errorWidget: (context, url, error) => Icon(
              Icons.image_not_supported,
              size: w / 10,
              color: Colors.red[900],
            ),
            placeholder: (context, url) => Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.black,
                  size: w / 26,
                ),
              ),
            ),
          ),
        ),
      ),
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

  static IconData setIcon(int messageState) {
    switch (messageState) {
      case 0:
        return Icons.access_time_outlined;
      case 1:
        return Icons.done_all;
      case 2:
        return Icons.done_all;
      case 3:
        return Icons.error_outline;
      default:
        return Icons.done;
    }
  }

  static Color setIconColor(int messageState) {
    switch (messageState) {
      case 0:
        return Colors.white;
      case 1:
        return Colors.white;
      case 2:
        return Colors.lightBlue;
      case 3:
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}
