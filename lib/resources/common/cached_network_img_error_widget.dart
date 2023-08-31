import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';

class CachedNetworkImgErrorWidget extends StatelessWidget {
  final double? textSize;
  final double? iconSize;
  final Color? textColor;

  const CachedNetworkImgErrorWidget({
    super.key,
    this.textSize = 40,
    this.iconSize = 25,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //  SizedBox(height: height / 100),
        Icon(
          Icons.info_outline,
          size: width / iconSize!,
          color: Colors.red.withOpacity(0.6),
        ),
        SizedBox(height: height / 100),
        MyTextPoppines(
          text: "Something went wrong while loading the images",
          fontSize: width / textSize!,
          color: textColor ?? AppColors.black.withOpacity(0.5),
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
          maxLines: 10,
        ),
      ],
    );
  }
}
