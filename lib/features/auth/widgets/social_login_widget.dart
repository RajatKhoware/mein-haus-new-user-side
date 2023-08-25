import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();

    _handleGoogleAuth() async {
      await notifier.googleAuth(context);
    }

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 1.h,
                  color: AppColors.grey.withOpacity(0.3),
                ),
              ),
              MyTextPoppines(
                text: "Or Login with",
                fontSize: 14.sp,
                color: AppColors.black.withOpacity(0.7),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 1.h,
                  color: AppColors.grey.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
        20.vs,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _handleGoogleAuth(),
              child: Container(
                width: 70.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.buttonBlue.withOpacity(0.3),
                  ),
                ),
                child: notifier.gLoading
                    ? Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: AppColors.textBlue,
                          size: 20.sp,
                        ),
                      )
                    : Image.asset(
                        "assets/logo/google.png",
                        scale: 20.sp,
                      ),
              ),
            ),
            10.hs,
            InkWell(
              onTap: () => AuthNotifier().logout(context),
              child: Container(
                width: 70.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.buttonBlue.withOpacity(0.3),
                  ),
                  image: DecorationImage(
                    image: const AssetImage(
                      "assets/logo/facebook.png",
                    ),
                    scale: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
