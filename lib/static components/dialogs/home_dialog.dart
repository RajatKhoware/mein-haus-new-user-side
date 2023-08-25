// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:new_user_side/features/estimate/screens/estimate_generation_screen.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../resources/common/buttons/my_buttons.dart';

class ShowDialogBox extends StatelessWidget {
  const ShowDialogBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        height: height / 2.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 12),
          image: const DecorationImage(
            image: AssetImage("assets/images/dailog_bg.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: width / 70, vertical: height / 40),
        child: Column(
          children: [
            SizedBox(height: height / 20),
            SizedBox(
              width: width / 2,
              child: MyTextPoppines(
                text:
                    "Have an estimate plan ?Let’s create an estimate for you.",
                fontSize: width / 26,
                fontWeight: FontWeight.w500,
                maxLines: 3,
                height: 1.4,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height / 30),
            MyBlueButton(
              hPadding: width / 8,
              text: "Okay..",
              vPadding: height / 70,
              fontSize: width / 22,
              onTap: () => Navigator.pushNamed(
                context,
                EstimateGenerationScreen.routeName,
                arguments: false,
              ),
            ),
            SizedBox(height: height / 45),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: MyTextPoppines(
                text: "Not Right Now",
                color: AppColors.textBlue,
                fontSize: width / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
