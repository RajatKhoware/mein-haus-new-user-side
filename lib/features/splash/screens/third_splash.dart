import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class ThirdSplashScreen extends StatelessWidget {
  const ThirdSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/workers/bg_1.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 70.h,
            right: 20.w,
            child: Container(
              width: 180.w,
              height: 180.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/workers/worker_7.png",
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
                    "assets/images/workers/worker_5.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height / 5,
            child: Container(
              width: width / 1.15,
              margin: EdgeInsets.symmetric(horizontal: width / 17),
              child: Center(
                child: MyTextPoppines(
                  text:
                      "Have your own pro? No Problem! Book through our platform for a seamless experience at no additional cost",
                  fontSize: width / 22,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  height: width / 300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
