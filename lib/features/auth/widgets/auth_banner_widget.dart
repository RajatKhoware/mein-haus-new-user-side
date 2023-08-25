import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/sizer.dart';

class AuthBannerWidget extends StatelessWidget {
  final bool? isSignIn;
  const AuthBannerWidget({
    Key? key,
    this.isSignIn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: 200.h,
      color: const Color(0xFFE9F4FF),
      child: Stack(
        children: [
          Positioned(
            left: -110.w,
            top: -20.h,
            child: CircleAvatar(
              radius: 150.r,
              backgroundColor: AppColors.buttonBlue.withOpacity(0.05),
            ),
          ),
          Positioned(
            right: -10.w,
            bottom: -20.h,
            child: CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.buttonBlue.withOpacity(0.1),
            ),
          ),
          Positioned(
            bottom: 50.h,
            left: 10.w,
            child: SizedBox(
              height: 60.h,
              width: 160.w,
              child: Image.asset(
                "assets/logo/logo_mein_haus.png",
              ),
            ),
          ),
          Positioned(
            left: 30.w,
            bottom: 10.h,
            child: MyTextPoppines(
              text: isSignIn! ? "Sign In " : "Sign up",
              fontSize: height > 800
                  ? height / MyFontSize.font22
                  : height / MyFontSize.font24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
