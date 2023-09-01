import 'package:flutter/material.dart';
import 'package:new_user_side/features/chat/widgets/sent_message.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../data/models/message_model.dart';
import '../../../utils/utils.dart';

class RecivedMessage extends StatelessWidget {
  final String senderImg;
  final Messages message;
  const RecivedMessage({
    Key? key,
    required this.senderImg,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final createdAt = message.createdAt.toString();
    final messageTime = Utils.convertToRailwayTime(createdAt);
    return Row(
      children: [
        SizedBox(width: w / 38),
        // Sender Img
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            senderImg,
            height: h / 30,
            width: w / 15,
          ),
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
              ChatHelper.showMessage(
                context: context,
                messageType: message.type ?? "text",
                message: message.message!,
                messageColor: AppColors.black,
              ),
              // mType(messageType!, context),
              SizedBox(width: w / 60),
              MyTextPoppines(
                text: messageTime,
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
}
