import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';

class SupportChatAppbar extends StatelessWidget {
  const SupportChatAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0.0,
      leading: Image.asset(
        "assets/icons/support_2.png",
      ),
      titleSpacing: 4.0,
      title: MyTextPoppines(text: "Customer support", fontSize: w / 22),
      actions: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: h / 70),
            padding: EdgeInsets.symmetric(horizontal: w / 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w / 40),
              border: Border.all(
                width: 1.0,
                color: AppColors.grey.withOpacity(0.4),
              ),
            ),
            child: Icon(
              CupertinoIcons.xmark,
              color: AppColors.black,
              size: w / 22,
            ),
          ),
        ),
        SizedBox(width: w / 30),
      ],
    );
  }
}
