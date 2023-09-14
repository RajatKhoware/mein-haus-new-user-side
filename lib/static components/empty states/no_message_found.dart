import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';

class NoMessageFound extends StatelessWidget {
  const NoMessageFound({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        SizedBox(height: height / 8),
        SvgPicture.asset('assets/svgs/something_went_wrong.svg'),
        SizedBox(height: height / 20),
        MyTextPoppines(
          text: "No Messages, yet",
          fontSize: width / 19,
          fontWeight: FontWeight.w600,
          // textAlign: TextAlign.center,
        ),
        SizedBox(height: height / 60),
        MyTextPoppines(
          text: "No messages in your indox yet!",
          fontSize: width / 30,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
          // textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
