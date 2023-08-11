// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';

class ProjectImgCardWidget extends StatelessWidget {
  final String imgPath;
  final double? width;
  final double? height;
  final double? borderWidth;
  final bool? isNetworkImg;
  const ProjectImgCardWidget({
    Key? key,
    required this.imgPath,
    this.width,
    this.height,
    this.borderWidth,
    this.isNetworkImg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 52.w,
      height: height ?? 46.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.white,
          width: borderWidth ?? 0.7,
        ),
        image: isNetworkImg!
            ? DecorationImage(
                image: NetworkImage(imgPath),
              )
            : DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
              ),
      ),
      child: isNetworkImg!
          ? CachedNetworkImage(
              imageUrl: imgPath,
              placeholder: (context, url) => cachedNetworkPlaceHolder,
              errorWidget: (context, url, error) => cachedNetworkErrorWidget,
            )
          : Image.asset(
              imgPath,
              fit: BoxFit.cover,
            ),
    );
  }
}
