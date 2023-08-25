import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_side/features/estimate/screens/estimate_generation_screen.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';


class EmptyProjectsStateWidget extends StatelessWidget {
  const EmptyProjectsStateWidget(
      {super.key, this.svgImg, required this.headline});
  final String? svgImg;
  final String headline;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 14),
      child: Column(
        children: [
          SizedBox(height: height / 40),
          SvgPicture.asset(svgImg ?? 'assets/svgs/no_completed_projects.svg'),
          SizedBox(height: height / 20),
          MyTextPoppines(
            text: headline,
            fontSize: width / 24,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            maxLines: 4,
          ),
          SizedBox(height: height / 60),
          MyTextPoppines(
            text:
                "Don’t worry! To start new project You can create new estimate by tapping below.",
            fontSize: width / 30,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            color: AppColors.black.withOpacity(0.5),
            height: 1.5,
            maxLines: 4,
          ),
          SizedBox(height: height / 20),
          MyBlueButton(
            hPadding: width / 10,
            vPadding: height / 55,
            fontSize: width / 25,
            text: "CREATE EST",
            onTap: () => Navigator.of(context).pushScreen(
              EstimateGenerationScreen(),
            ),
          )
        ],
      ),
    );
  }
}
