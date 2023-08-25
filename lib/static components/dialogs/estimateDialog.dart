// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';

import '../../resources/common/my_text.dart';

class EstimateDialog extends StatelessWidget {
  const EstimateDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: height > 800 ? 360.h : 350.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          image: const DecorationImage(
            image: AssetImage("assets/images/dailog_bg.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          children: [
            35.vs,
            SizedBox(
                width: 85.w,
                height: 85.h,
                child: Image.asset("assets/icons/done.png")),
            10.vs,
            SizedBox(
              height: height > 800 ? 70.h : 60.h,
              child: Align(
                alignment: Alignment.center,
                child: MyTextPoppines(
                  text:
                      "Your estimate has been created successfully. we will contact you shortly",
                  fontSize: height / MyFontSize.font14,
                  fontWeight: FontWeight.w500,
                  maxLines: 3,
                  height: 1.3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            20.vs,
            MyBlueButton(
              hPadding: 40.w,
              text: "Back To Home",
              onTap: () => Navigator.pushNamed(context, HomeScreen.routeName),
            ),
            20.vs,
          ],
        ),
      ),
    );
  }
}
