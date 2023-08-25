import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';

class HomeOfferBanner extends StatelessWidget {
  const HomeOfferBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    BorderRadius borderRadius = BorderRadius.circular(24.r);
    Border border = Border.all(
      width: 1.2,
      color: AppColors.grey.withOpacity(0.2),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: height / 4.46,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: border,
          image: const DecorationImage(
            image: AssetImage("assets/images/room/house.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Row(
          children: [
            20.hs,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height > 800 ? 20.vs : 25.vs,
                MyTextPoppines(
                  text: "Get 20% OFF",
                  fontSize: height > 800
                      ? height / MyFontSize.font20
                      : height / MyFontSize.font24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                15.vs,
                SizedBox(
                  width: 200.w,
                  child: MyTextPoppines(
                    text: "Tap on banner to see more in details.",
                    fontSize: height > 800
                        ? height / MyFontSize.font10
                        : height / MyFontSize.font14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    height: 1.2.h,
                  ),
                ),
                15.vs,
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: Border.all(
                        width: 1.2.w,
                        color: AppColors.white,
                      ),
                      color: AppColors.buttonBlue,
                    ),
                    child: Center(
                      child: MyTextPoppines(
                        text: "View Details",
                        fontSize: height / MyFontSize.font12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: double.infinity,
              width: 110.w,
              child: Image.asset(
                "assets/images/workers/worker_1.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
