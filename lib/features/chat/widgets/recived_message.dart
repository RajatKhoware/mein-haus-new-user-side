import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_user_side/features/chat/widgets/preview_chat_images.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/download_files/download_file.dart';

class RecivedMessage extends StatelessWidget {
  final String sendText;
  final String timeOfText;
  final String? messageType;
  const RecivedMessage({
    Key? key,
    required this.sendText,
    required this.timeOfText,
    this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Row(
      children: [
        SizedBox(width: w / 38),
        // Sender Img
        Image.asset(
          "assets/icons/support_2.png",
          height: h / 30,
          width: w / 15,
        ),
        SizedBox(width: w / 80),
        // Message
        Container(
          margin: EdgeInsets.only(
            left: w / 38,
            top: h / 80,
            bottom: h / 80,
            right: w / 6,
          ),
          padding: EdgeInsets.symmetric(horizontal: w / 30, vertical: h / 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(w / 20),
              topRight: Radius.circular(w / 20),
              bottomRight: Radius.circular(w / 20),
            ),
            color: const Color(0xFFC1C1C1).withOpacity(0.20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              mType(messageType!, context),
              SizedBox(width: w / 60),
              MyTextPoppines(
                text: timeOfText,
                fontSize: w / 32,
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.6),
                maxLines: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget mType(String type, BuildContext context) {
    final w = context.screenWidth;
    final textMessage = SizedBox(
      width: w / 1.9,
      child: MyTextPoppines(
        text: sendText,
        fontSize: w / 32,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
        maxLines: 100,
      ),
    );
    final pdfMessage = DownloadFile(fileNmae: sendText);
    final imgMessage = SizedBox(
      width: w / 1.9,
      child: InkWell(
        onTap: () => Navigator.of(context).pushScreen(
          PreviewChatImages(imgPath: sendText),
        ),
        child: Hero(
          tag: sendText,
          child: CachedNetworkImage(
            imageUrl: sendText,
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
    switch (type) {
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
