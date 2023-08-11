// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/provider/notifiers/additional_work_notifier.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/res/common/buttons/my_buttons.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/get_images.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:provider/provider.dart';

import '../../../res/common/my_app_bar.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/show_picked_images.dart';
import '../../../utils/utils.dart';
import '../../estimate/widget/download_pdf_card_widget.dart';

class AddAdditionalWorkScreen extends StatefulWidget {
  static const String routeName = '/addAddtionalWorkScreen';
  const AddAdditionalWorkScreen({
    Key? key,
    required this.projectId,
  }) : super(key: key);
  final String projectId;

  @override
  State<AddAdditionalWorkScreen> createState() =>
      _AddAdditionalWorkScreenState();
}

class _AddAdditionalWorkScreenState extends State<AddAdditionalWorkScreen> {
  final _additionalWorkFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleNode = FocusNode();
  FocusNode descNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    titleNode.dispose();
    descNode.dispose();
  }

  Future getImages() async {
    await GetImages().pickImages<AdditionalWorkNotifier>(context: context);
  }

  _requestHandler() async {
    final notifier = context.read<AdditionalWorkNotifier>();
    final image = await Utils.collectImages(notifier.images);
    final Map<String, dynamic> body = {
      'estimate_service_id': widget.projectId,
      'title': titleController.text,
      'description': descriptionController.text,
      'images[]': image,
    };
    if (_additionalWorkFormKey.currentState!.validate()) {
      await notifier.requestAdditonalWork(
        context: context,
        body: body,
      );
      titleController.clear();
      descriptionController.clear();
    }
  }

  _getAdditionalWorkHandler() async {
    final notifier = context.read<AdditionalWorkNotifier>();
    await notifier.getAdditonalWork(
      context: context,
      projectId: widget.projectId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AdditionalWorkNotifier>();
    final projectNotifer = context.read<EstimateNotifier>().projectDetails;
    final project = projectNotifer.services!;
    return ModalProgressHUD(
      inAsyncCall: notifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Additional Work"),
        body: Column(
          children: [
            DownloadPdfCard(
              workName: project.projectName.toString(),
              isAddonWork: true,
              projectId: project.estimateNo.toString(),
            ),
            Divider(thickness: 2, height: 9.h),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MyTextPoppines(
                        text:
                            "This is for adding to the scope of work that your current pro can provide.",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      15.vs,
                      Form(
                        key: _additionalWorkFormKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            MyTextField(
                              text: "Enter the title to add on",
                              hintText: "Title name",
                              headingFontWeight: FontWeight.w500,
                              isHs20: false,
                              controller: titleController,
                              validator: Validator().nullValidator,
                              focusNode: titleNode,
                              onSubmit: (p0) {
                                Utils.fieldFocusChange(
                                    context, titleNode, descNode);
                              },
                            ),
                            MyTextField(
                              text: "Description",
                              hintText: "Enter brief description",
                              headingFontWeight: FontWeight.w500,
                              maxLines: 4,
                              isHs20: false,
                              controller: descriptionController,
                              validator: Validator().nullValidator,
                              focusNode: descNode,
                            ),
                          ],
                        ),
                      ),
                      // Picking and Showing images
                      10.vs,
                      if (notifier.images.length == 0)
                        SelectFileButton(
                          onTap: () => notifier.getImages(context),
                        ),
                      20.vs,
                      if (notifier.images.length != 0)
                        ShowPickedImages<AdditionalWorkNotifier>(),
                      10.vs,
                      const Divider(thickness: 1.5),
                      10.vs,
                      Align(
                        alignment: Alignment.center,
                        child: MyBlueButton(
                          // isWaiting: notifier.loading,
                          hPadding: 80.w,
                          text: "Request it",
                          onTap: () => _requestHandler(),
                        ),
                      ),
                      10.vs,
                      const Divider(thickness: 1.5),
                      10.vs,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          color: AppColors.yellow.withOpacity(0.2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MyTextPoppines(
                              text:
                                  "Tap here to view your all additional work details.",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              height: 1.3,
                            ),
                            InkWell(
                              onTap: () => _getAdditionalWorkHandler(),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(
                                    width: 1.5.w,
                                    color: AppColors.textBlue1E9BD0,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 7.h,
                                ),
                                child: MyTextPoppines(
                                  text: "View Details",
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.buttonBlue,
                                  fontSize: 10.sp,
                                  // height: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectFileButton extends StatelessWidget {
  final VoidCallback onTap;
  const SelectFileButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: height > 800 ? 140.w : 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.textBlue1E9BD0,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            MyTextPoppines(
              text: "Select File",
              fontWeight: FontWeight.w500,
              color: AppColors.buttonBlue,
              fontSize: 14.sp,
              // height: 1.6,
            ),
            5.hs,
            Icon(
              Icons.attach_file,
              color: AppColors.buttonBlue,
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
