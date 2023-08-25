import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';

import '../../../utils/constants/app_colors.dart';

class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/workers/bg_2.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: 60.h,
          right: 20.w,
          child: Container(
            width: 220.w,
            height: 220.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/workers/worker_2.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: 280.h,
          left: 20.w,
          child: Container(
            width: 180.w,
            height: 180.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/workers/worker_4.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 190.h,
          left: 20.w,
          child: SizedBox(
            width: 350.w,
            child: MyTextPoppines(
              text: "Instant quotation tailored to you.",
              fontSize: height > 800 ? 18.sp : 22.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ),
        Positioned(
          bottom: 145.h,
          left: 20.w,
          child: SizedBox(
            width: 350.w,
            child: MyTextPoppines(
              text:
                  "Pay a fixed price at the best market rates. Guaranteed to completion  ",
              fontSize: height > 800 ? 10.sp : 12.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.black.withOpacity(0.6),
            ),
          ),
        ),
      ]),
    );
  }
}
