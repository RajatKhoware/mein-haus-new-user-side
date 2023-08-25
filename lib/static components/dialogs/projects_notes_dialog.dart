// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/features/project%20notes/view/screens/project_notes_screen.dart';
import 'package:new_user_side/provider/notifiers/saved_notes_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/get_images.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:provider/provider.dart';

import '../../utils/extensions/show_picked_images.dart';
import '../../utils/utils.dart';

class ProjectNotesDialog extends StatefulWidget {
  final String serviceId;
  const ProjectNotesDialog({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  @override
  State<ProjectNotesDialog> createState() => _ProjectNotesDialogState();
}

class _ProjectNotesDialogState extends State<ProjectNotesDialog> {
  final _noteFormKey = GlobalKey<FormState>();
  TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  Future getImages() async {
    await GetImages().pickImages<SavedNotesNotifier>(context: context);
  }

  Future _savedNoteForMeHandler() async {
    final notifer = context.read<SavedNotesNotifier>();
    final image = await Utils.collectImages(notifer.images);
    final Map<String, dynamic> body = {
      'estimate_service_id': widget.serviceId,
      'note': noteController.text,
      "images[]": image,
    };
    if (_noteFormKey.currentState!.validate())
      await notifer.savedNoteForMe(
        context: context,
        body: body,
      );
  }

  Future _savedNoteForMeAndProHandler() async {
    final notifer = context.read<SavedNotesNotifier>();
    final image = await Utils.collectImages(notifer.images);
    final Map<String, dynamic> body = {
      'estimate_service_id': widget.serviceId,
      'note': noteController.text,
      "images[]": image,
    };
    if (_noteFormKey.currentState!.validate())
      await notifer.savedNoteForMeAndPro(
        context: context,
        body: body,
      );
  }

  _getSavedNotesHandler() async {
    final notifer = context.read<SavedNotesNotifier>();
    await notifer.getSavedNotes(context: context, id: widget.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    final notifer = context.watch<SavedNotesNotifier>();
    final height = context.screenHeight;
    return Dialog(
      backgroundColor: Colors.white,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.vs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyTextPoppines(
                          text: "Project Notes",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        10.hs,
                        Image.asset("assets/icons/project_notes.png"),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        radius: 10.r,
                        backgroundColor: AppColors.textBlue.withOpacity(0.15),
                        child: Icon(
                          CupertinoIcons.xmark,
                          size: 14.sp,
                          color: AppColors.black,
                        ),
                      ),
                    )
                  ],
                ),
                10.vs,
                SizedBox(
                  width: 324.w,
                  child: MyTextPoppines(
                    text:
                        "Use these notes like a notebook of things you want to remember about your job, like which color/material goes where, or special details about an installation.",
                    fontSize: context.screenWidth / 40,
                    fontWeight: FontWeight.w500,
                    maxLines: 3,
                    height: 1.3,
                  ),
                ),
                const Divider(thickness: 1.5),
                10.vs,
                Form(
                  key: _noteFormKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: MyTextField(
                    text: "Enter Your Notes Below",
                    headingFontWeight: FontWeight.w500,
                    maxLines: 4,
                    hintText: " Write Notes Here..",
                    isHs20: false,
                    controller: noteController,
                    validator: Validator().nullValidator,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          await _getSavedNotesHandler();
                          Navigator.pushNamed(
                            context,
                            SavedNotesScreen.routeName,
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              "Saved Notes",
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: AppColors.textBlue1E9BD0,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2.0,
                              ),
                            ),
                            Icon(
                              Icons.bookmark_border,
                              color: const Color.fromARGB(255, 72, 185, 233),
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => getImages(),
                        child: _Button(
                          buttonText: "Select File",
                          iconData: Icons.attach_file,
                          fontSize: 12.sp,
                          vPadding: 3.h,
                          iconSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                notifer.images.isNotEmpty
                    ? ShowPickedImages<SavedNotesNotifier>()
                    : SizedBox(),
                const Divider(thickness: 1.5),
                10.vs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => _savedNoteForMeHandler(),
                      child: _Button(
                        buttonText: "Save For Me Only",
                        iconData: Icons.bookmark,
                        fontSize: height > 800 ? 8.sp : 10.sp,
                        vPadding: 10.h,
                        iconSize: height > 800 ? 14.sp : 16.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () => _savedNoteForMeAndProHandler(),
                      child: _Button(
                        buttonText: "Save For Me & Pro",
                        iconData: Icons.bookmark,
                        fontSize: height > 800 ? 8.sp : 10.sp,
                        vPadding: 10.h,
                        iconSize: height > 800 ? 14.sp : 16.sp,
                        isBorder: false,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String buttonText;
  final IconData iconData;
  final bool? isBorder;
  final double? vPadding;
  final double? fontSize;
  final double? iconSize;
  const _Button({
    Key? key,
    required this.buttonText,
    required this.iconData,
    this.isBorder = true,
    this.vPadding = 5,
    this.fontSize = 14,
    this.iconSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.textBlue1E9BD0,
        ),
        color: isBorder! ? null : AppColors.buttonBlue,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: vPadding!.h),
      child: Row(
        children: [
          MyTextPoppines(
            text: buttonText,
            fontWeight: FontWeight.w500,
            color: isBorder! ? AppColors.buttonBlue : AppColors.white,
            fontSize: fontSize!.sp,
            height: 1.6,
          ),
          5.hs,
          Icon(
            iconData,
            color: isBorder! ? AppColors.buttonBlue : AppColors.white,
            size: iconSize!.sp,
          ),
        ],
      ),
    );
  }
}
