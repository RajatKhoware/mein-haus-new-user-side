// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class CameraViewPage extends StatelessWidget {
  final VoidCallback onTap;
  final String imgPath;
  const CameraViewPage({
    Key? key,
    required this.onTap,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0.0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.white,
            size: w / 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: AppColors.white,
              size: w / 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.crop_rotate,
              color: AppColors.white,
              size: w / 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.title,
              color: AppColors.white,
              size: w / 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.emoji_emotions,
              color: AppColors.white,
              size: w / 20,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(imgPath).absolute),
              ),
            ),
          ),
          SizedBox(height: h / 80),
          Positioned(
            bottom: h / 40,
            right: w / 20,
            child: InkWell(
              onTap: onTap,
              child: CircleAvatar(
                backgroundColor: Colors.green.shade600,
                radius: w / 15,
                child: Icon(
                  Icons.done,
                  color: AppColors.white,
                  size: w / 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
