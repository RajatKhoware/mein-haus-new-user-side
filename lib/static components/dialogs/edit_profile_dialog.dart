// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../../resources/common/buttons/my_buttons.dart';


class EditProfilePicDialog extends StatelessWidget {
  final VoidCallback onTapAtOk;
  const EditProfilePicDialog({
    Key? key,
    required this.onTapAtOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        height: height / 2.53,
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
            MyTextPoppines(
              text: "Unsaved Changes",
              fontSize: height / 40,
              fontWeight: FontWeight.w500,
              maxLines: 3,
              height: 1.4,
              textAlign: TextAlign.center,
            ),
            20.vs,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: MyTextPoppines(
                text:
                    "You have unsaved changes. Are you sure you want to cancel?",
                fontSize: height / 50,
                fontWeight: FontWeight.w500,
                maxLines: 3,
                height: 1.4,
                textAlign: TextAlign.center,
              ),
            ),
            30.vs,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyBlueButton(
                  hPadding: 40.w,
                  text: "Ok",
                  vPadding: 10.h,
                  fontSize: height / 48,
                  onTap: onTapAtOk,
                ),
                MyBlueButton(
                  hPadding: 40.w,
                  text: "No",
                  vPadding: 10.h,
                  fontSize: height / 48,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            10.vs,
          ],
        ),
      ),
    );
  }
}
