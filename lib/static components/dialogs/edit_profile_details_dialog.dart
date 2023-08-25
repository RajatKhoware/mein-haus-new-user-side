// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../resources/common/my_text.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/sizer.dart';

class EditProfileDetailsDialog extends StatelessWidget {
  const EditProfileDetailsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        height: height / 2.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextPoppines(
                    text: "Baisc Info",
                    fontSize: context.screenHeight / MyFontSize.font14,
                    fontWeight: FontWeight.w600,
                    height: 1.8,
                    textAlign: TextAlign.center,
                    color: AppColors.black.withOpacity(0.8),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: AppColors.textBlue.withOpacity(0.15),
                      child: Icon(
                        CupertinoIcons.xmark,
                        size: 12.sp,
                        color: AppColors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 10.h),
              child: Column(
                children: [
                  const _TextField(
                    hText: "Your Name",
                    hintText: "John Doe",
                  ),
                  const _TextField(
                    hText: "Mobile No",
                    hintText: "(+1) (312) 090909",
                  ),
                  const _TextField(
                    hText: "Email ID",
                    hintText: "user1meinhause@gmail.com",
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1.0),
            5.vs,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        width: 0.8,
                        color: AppColors.textBlue1E9BD0,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    child: Center(
                      child: MyTextPoppines(
                        text: "Cancel",
                        fontWeight: FontWeight.w500,
                        fontSize: context.screenHeight / MyFontSize.font12,
                        color: AppColors.textBlue1E9BD0,
                      ),
                    ),
                  ),
                ),
                20.hs,
                MyBlueButton(
                  hPadding: 20.w,
                  vPadding: 8.h,
                  isRoundedBorder: false,
                  text: "Save",
                  fontSize: context.screenHeight / MyFontSize.font12,
                  onTap: () {},
                ),
                10.hs,
              ],
            ),
            5.vs,
          ],
        ),
      ),
    );
 
  }
}

class _TextField extends StatelessWidget {
  final String hText;
  final String hintText;
  final bool? isEditable;
  const _TextField({
    Key? key,
    required this.hText,
    required this.hintText,
    this.isEditable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: hText,
            fontSize: context.screenHeight / MyFontSize.font12,
          ),
          SizedBox(
            height: 35.h,
            child: TextFormField(
              enabled: isEditable,
              style: GoogleFonts.poppins(
                fontSize: context.screenHeight / MyFontSize.font12,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10.h),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.grey.withOpacity(0.4),
                    width: 0.7,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColors.textBlue1E9BD0,
                  width: 0.7,
                )),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: context.screenHeight / MyFontSize.font12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
