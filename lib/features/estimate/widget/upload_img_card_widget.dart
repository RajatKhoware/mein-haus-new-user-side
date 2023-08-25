import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../../../resources/common/my_text.dart';

class UploadImgCardWidget extends StatelessWidget {
  const UploadImgCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextPoppines(
          text: " Upload pictures of the project",
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        15.vs,
        Padding(
          padding: EdgeInsets.only(left: 25.w),
          child: DottedBorder(
            dashPattern: const [4, 6],
            strokeCap: StrokeCap.round,
            borderType: BorderType.RRect,
            radius: Radius.circular(12.r),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            color: AppColors.black.withOpacity(0.5),
            child: SizedBox(
              height: 90.h,
              width: double.infinity,
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/imgs.png",
                    fit: BoxFit.fitWidth,
                    width: 230.w,
                  ),
                  20.hs,
                  Icon(
                    Icons.add_circle,
                    size: 35.sp,
                    color: AppColors.textBlue,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
