// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/provider/notifiers/additional_work_notifier.dart';
import 'package:new_user_side/provider/notifiers/customer_support_notifier.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/provider/notifiers/saved_notes_notifier.dart';
import 'package:new_user_side/provider/notifiers/upload_image_notifier.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class ShowPickedImages<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifer = context.watch<T>();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return DottedBorder(
      dashPattern: const [4, 2],
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: Radius.circular(6),
      padding:
          EdgeInsets.symmetric(horizontal: width / 50, vertical: height / 90),
      color: AppColors.black.withOpacity(0.5),
      child: SizedBox(
        height: height / 7,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: height / 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color.fromARGB(40, 136, 130, 130),
              ),
              child: Center(
                child: MyTextPoppines(
                  text: "Double tap to remove image 🗑",
                  fontSize: context.screenWidth / 40,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            2.vspacing(context),
            if (notifer is CustomerSupportNotifier) _ShowImg(notifer),
            if (notifer is UploadImgNotifier) _ShowImg(notifer),
            if (notifer is SavedNotesNotifier) _ShowImg(notifer),
            if (notifer is EstimateNotifier) _ShowImg(notifer),
            if (notifer is AdditionalWorkNotifier) _ShowImg(notifer),
          ],
        ),
      ),
    );
  }
}

class _ShowImg extends StatelessWidget {
  final notifer;
  const _ShowImg(this.notifer);

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notifer.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final image = notifer.images[index];
                return InkWell(
                  onDoubleTap: () => notifer.removeImageFromList(image),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 60),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width / 200),
                        border: Border.all(color: AppColors.grey, width: 1),
                      ),
                      padding: EdgeInsets.all(width / 200),
                      child: Image.file(File(image.path).absolute),
                    ),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () => notifer.getImagess(context),
            child: Icon(
              Icons.add_circle,
              size: width / 10,
              color: AppColors.textBlue,
            ),
          ),
        ],
      ),
    );
  }
}
