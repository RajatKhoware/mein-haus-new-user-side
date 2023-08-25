import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../../../utils/sizer.dart';
import 'my_buttons.dart';

class MyBottomNavWidget extends StatelessWidget {
  final double hPadding;
  final String text;
  final VoidCallback onTap;
  const MyBottomNavWidget({
    Key? key,
    required this.hPadding,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Column(
        children: [
          2.vs,
          Divider(thickness: 1.5, indent: 10.w, endIndent: 10.w),
          10.vs,
          MyBlueButton(
            hPadding: hPadding,
            text: text,
            onTap: onTap,
            fontSize: context.screenHeight / MyFontSize.font16,
          ),
        ],
      ),
    );
  }
}
