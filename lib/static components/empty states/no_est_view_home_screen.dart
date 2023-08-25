// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_side/features/estimate/screens/estimate_generation_screen.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class NoEstViewHomeScreenWidget extends StatelessWidget {
  final String text;
  const NoEstViewHomeScreenWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        Container(
          width: width,
          height: height / 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 30),
            color: AppColors.white,
            border: Border.all(color: AppColors.golden),
          ),
          padding: EdgeInsets.all(width / 130),
          child: SvgPicture.asset(
            'assets/svgs/no_estimate.svg',
            fit: BoxFit.cover,
            width: width,
            height: height / 5,
          ),
        ),
        Positioned(
          right: width / 16,
          top: height / 35,
          child: SizedBox(
            width: width / 2.6,
            child: Column(
              children: [
                MyTextPoppines(
                  text: text,
                  fontSize: width / 30,
                  fontWeight: FontWeight.w500,
                  maxLines: 5,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: height / 50),
                InkWell(
                  onTap: () => Navigator.of(context).pushScreen(
                    EstimateGenerationScreen(),
                  ),
                  child: Container(
                    width: width / 3,
                    height: height / 26,
                    decoration: BoxDecoration(
                      color: AppColors.buttonBlue.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(width / 40),
                      border: Border.all(color: AppColors.buttonBlue),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyTextPoppines(
                          text: "Create New EST",
                          fontSize: width / 34,
                          fontWeight: FontWeight.w700,
                          color: AppColors.buttonBlue,
                          height: 1.4,
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: width / 20,
                          color: AppColors.buttonBlue,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
