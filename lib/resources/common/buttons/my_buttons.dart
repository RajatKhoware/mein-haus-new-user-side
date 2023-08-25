// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class MyBlueButton extends StatelessWidget {
  final double hPadding;
  final String text;
  final VoidCallback onTap;
  final double? vPadding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isRoundedBorder;
  final bool? isWaiting;
  const MyBlueButton({
    Key? key,
    required this.hPadding,
    required this.text,
    required this.onTap,
    this.vPadding,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.isRoundedBorder = true,
    this.isWaiting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        decoration: BoxDecoration(
          borderRadius: isRoundedBorder ?? true
              ? BorderRadius.circular(40.r)
              : BorderRadius.circular(6.r),
          color: AppColors.buttonBlue,
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isWaiting! ? 12.w : hPadding.w,
          vertical: isWaiting! ? vPadding ?? height/50 - 5.h : vPadding ?? height/50,
        ),
        child: isWaiting!
            ? SizedBox(
                width: 25.w,
                height: 25.h,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.w,
                ),
              )
            : MyTextPoppines(
                text: text,
                color: AppColors.white,
                fontWeight: fontWeight,
                fontSize: fontSize!.sp,
              ),
      ),
    );
  }
}
