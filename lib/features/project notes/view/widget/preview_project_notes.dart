// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/provider/notifiers/saved_notes_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../../data/models/saved_notes_model.dart';

class PreviewProjectNotes extends StatefulWidget {
  const PreviewProjectNotes({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Notes note;

  @override
  State<PreviewProjectNotes> createState() => _PreviewProjectNotesState();
}

int currentIndex = 0;

class _PreviewProjectNotesState extends State<PreviewProjectNotes> {
  @override
  Widget build(BuildContext context) {
    final note = widget.note;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: height / 1.6,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            3.vspacing(context),
            Align(
              alignment: Alignment.center,
              child: MyTextPoppines(
                text: "Saved Notes for me",
                fontSize: width / 27,
                fontWeight: FontWeight.w600,
              ),
            ),
            1.vspacing(context),
            Divider(thickness: 1.0),
            2.vspacing(context),
            Row(
              children: [
                10.hspacing(context),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (currentIndex > 0) --currentIndex;
                    });
                  },
                  child: currentIndex != 0
                      ? Icon(
                          CupertinoIcons.back,
                          color: AppColors.buttonBlue,
                        )
                      : SizedBox(width: width / 16),
                ),
                7.hspacing(context),
                Container(
                  width: width / 2,
                  height: height / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: AppColors.whiteF5F5F5,
                    border: Border.all(color: AppColors.golden),
                    image: note.images!.length == 0
                        ? DecorationImage(
                            image:
                                AssetImage("assets/images/image_not_found.png"),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(
                                note.images![currentIndex].thumbnailUrl!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                7.hspacing(context),
                note.images == null
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          setState(() {
                            if (currentIndex < (note.images!.length - 1))
                              currentIndex++;
                          });
                        },
                        child: currentIndex < (note.images!.length - 1)
                            ? Icon(
                                CupertinoIcons.forward,
                                color: AppColors.buttonBlue,
                              )
                            : SizedBox(),
                      )
              ],
            ),
            2.vspacing(context),
            Divider(thickness: 1.0),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  child: MyTextPoppines(
                    text: note.note ?? "",
                    fontSize: height / 80,
                    fontWeight: FontWeight.w600,
                    maxLines: 5,
                    color: AppColors.black.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
