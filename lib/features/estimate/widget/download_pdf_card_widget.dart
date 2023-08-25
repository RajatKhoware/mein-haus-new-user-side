// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';

class DownloadPdfCard extends StatelessWidget {
  final String workName;
  final String? projectId;
  final bool? isAddonWork;
  const DownloadPdfCard({
    Key? key,
    required this.workName,
    this.projectId,
    this.isAddonWork = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w / 28, vertical: h / 85),
      color: AppColors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: h / 300),
            child: isAddonWork!
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: w / 1.1,
                        child: MyTextPoppines(
                          text: workName,
                          fontSize: w / 28,
                          color: AppColors.white,
                        ),
                      ),
                      3.vs,
                      MyTextPoppines(
                        text: projectId!,
                        fontSize: height / MyFontSize.font11,
                        color: AppColors.yellow,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
                : SizedBox(
                    width: w / 1.1,
                    child: MyTextPoppines(
                      text: workName,
                      fontSize: w / 26,
                      color: AppColors.white,
                    ),
                  ),
          ),
          // Row(
          //   children: [
          //     Text(
          //       "Download as PDF",
          //       style: GoogleFonts.poppins(
          //         fontSize: w / 34,
          //         fontWeight: FontWeight.w600,
          //         fontStyle: FontStyle.normal,
          //         color: AppColors.yellow,
          //         decoration: TextDecoration.underline,
          //         decorationThickness: 2.0,
          //         // height: 2,
          //       ),
          //     ),
          //     Icon(
          //       Icons.file_download_outlined,
          //       color: AppColors.yellow,
          //       size: 24.sp,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
