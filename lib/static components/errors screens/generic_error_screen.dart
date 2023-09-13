import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_snake_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';

class GenericErrorScreen extends StatelessWidget {
  final String svgImg;
  final String errorHeading;
  final String errorSubHeading;
  const GenericErrorScreen({
    super.key,
    required this.svgImg,
    required this.errorHeading,
    required this.errorSubHeading,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E9BD0).withOpacity(.2),
              Color(0xFF1E9BD013).withOpacity(.076),
              Color(0xFF1E9BD0).withOpacity(.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 8),
          child: Column(
            children: [
              SizedBox(height: height / 6),
              SvgPicture.asset(svgImg),
              SizedBox(height: height / 40),
              MyTextPoppines(
                text: errorHeading,
                color: Colors.purple.shade900,
                fontSize: width / 20,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height / 40),
              MyTextPoppines(
                text: errorSubHeading,
                color: AppColors.black.withOpacity(0.5),
                fontSize: width / 28,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                maxLines: 10,
                height: 1.6,
              ),
              SizedBox(height: height / 5),
              MyBlueButton(
                hPadding: width / 5.3,
                vPadding: height / 60,
                text: "BACK",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: height / 50),
              InkWell(
                onTap: () {
                  showSnakeBar(
                      context, "This feature is still need to integrate");
                },
                child: Container(
                  width: width / 2.0,
                  height: height / 17,
                  decoration: BoxDecoration(
                    //   color: AppColors.black,
                    borderRadius: BorderRadius.circular(width / 16),
                    border: Border.all(
                      width: 2,
                      color: AppColors.buttonBlue,
                    ),
                  ),
                  child: Center(
                    child: MyTextPoppines(
                      text: "REPORT TO SUPPORT",
                      fontSize: width / 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlue,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
