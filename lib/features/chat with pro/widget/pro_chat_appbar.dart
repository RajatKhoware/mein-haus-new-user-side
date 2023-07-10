// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';


class ProChatAppBar extends StatelessWidget {
  const ProChatAppBar({
    Key? key,
    required this.senderName,
    required this.senderImg,
  }) : super(key: key);
  final String senderName;
  final String senderImg;

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return AppBar(
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
          size: w / 20,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      title: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: w / 22,
                backgroundImage: senderImg.isEmpty
                    ? AssetImage("assets/images/face/man_1.png")
                    : NetworkImage(senderImg) as ImageProvider<Object>,
              ),
              Positioned(
                right: 0,
                top: h / 300,
                child: CircleAvatar(
                  radius: w / 100,
                  backgroundColor: AppColors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: w / 40),
          MyTextPoppines(
            text: senderName,
            fontSize: w / 28,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
      actions: [
        Icon(
          CupertinoIcons.ellipsis_vertical,
          color: AppColors.black,
          size: w / 22,
        ),
        SizedBox(width: w / 40),
      ],
    );
  }
}
