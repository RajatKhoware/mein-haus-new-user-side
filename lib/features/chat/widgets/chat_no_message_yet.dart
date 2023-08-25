// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class NoMessageYetWidget extends StatelessWidget {
  const NoMessageYetWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(w / 20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(12, 0, 0, 0),
            offset: const Offset(0, 0),
            blurRadius: w / 40,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: w / 10,
        vertical: h / 20,
      ),
      margin: EdgeInsets.only(top: h / 7),
      child: Column(
        children: [
          MyTextPoppines(
            text: "No Messages yet.",
            fontSize: w / 20,
            color: AppColors.yellow,
          ),
          SizedBox(height: h / 40),
          MyTextPoppines(
            text: "Send a message to \n     chat with Pro.",
            fontSize: w / 24,
            color: AppColors.black.withOpacity(0.4),
          ),
          SizedBox(height: h / 40),
          SizedBox(
            height: h / 8,
            width: w / 2,
            child: Image.asset("assets/icons/message.png"),
          ),
        ],
      ),
    );
  }
}
