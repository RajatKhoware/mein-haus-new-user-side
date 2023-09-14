// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/data/models/conversation_list_model.dart';
import 'package:new_user_side/data/models/ongoing_project_model.dart';
import 'package:new_user_side/features/chat/screen/chatting_screen.dart';
import 'package:new_user_side/features/customer%20support/screens/customer_support_send_query_screen.dart';
import 'package:new_user_side/features/project%20notes/view/screens/project_notes_screen.dart';

import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/static%20components/dialogs/pro_work_details_dialog.dart';
import 'package:new_user_side/static%20components/dialogs/projects_notes_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/additional_work_notifier.dart';
import '../../../provider/notifiers/saved_notes_notifier.dart';
import '../../../resources/common/my_text.dart';
import '../../additional work/screens/add_addition_work_screen.dart';
import '../../additional work/screens/additional_work_from_pro_screen.dart';
import '../../additional work/widget/icon_button_with_text.dart';
import '../../invoice/screens/progess_invoice_screen.dart';

class OngoingJobsButtonsPanel extends StatelessWidget {
  const OngoingJobsButtonsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final supportNotifier = context.watch<SupportNotifier>();
    final estimateNotifer = context.read<EstimateNotifier>();
    final project = estimateNotifer.projectDetails.services!;
    final isSupportActive = supportNotifier.supportStatus == 1;
    final bookingId = project.estimateNo;
    final isNormalProject = project.normal!;
    final projectId = project.projectId.toString();
    final isProjectCompleted = project.isCompleted!;

    // get invoice data
    void _getInvoiceHandler() {
      final estimateNotifer = context.read<EstimateNotifier>();
      Navigator.of(context).pushScreen(ProgressInvoiceScreen());
      estimateNotifer.progressInvoice(
        context: context,
        bookingId: bookingId!,
      );
    }

    // Getting all the additional work requested by user
    _getAdditionalWorkHandler() async {
      final notifier = context.read<AdditionalWorkNotifier>();
      await notifier.getAdditonalWork(
        context: context,
        projectId: projectId,
      );
    }

    // To get all the saved notes
    _getSavedNotesHandler() async {
      final notifer = context.read<SavedNotesNotifier>();
      await notifer.getSavedNotes(context: context, id: projectId);
      Navigator.of(context).pushScreen(SavedNotesScreen());
    }

    // onTap Customer Button
    _onTapCustomerButton() {
      isSupportActive
          ? Navigator.of(context).pushScreen(
              ChattingScreen(
                isChatWithPro: false,
                estimateId: project.projectId.toString(),
              ),
            )
          : Navigator.of(context).pushNamed(
              SendQueryScreen.routeName,
            );
    }

    // onTap Project Notes
    _onTapProjectNotesButton() {
      isProjectCompleted
          ? _getSavedNotesHandler()
          : showDialog(
              context: context,
              builder: (context) {
                return ProjectNotesDialog(
                  serviceId: projectId,
                );
              },
            );
    }

    // Navigate to chatting screen
    void onMessageProTapped() async {
      final projectNotifer =
          context.read<EstimateNotifier>().projectDetails.services;
      final proNotifier = context.read<EstimateNotifier>().proDetails.prodata;
      Navigator.of(context).pushScreen(
        ChattingScreen(
          isChatWithPro: true,
          sendUserId: proNotifier!.proId,
          estimateId: projectNotifer!.projectId.toString(),
          conversations: Conversations(
            profilePicture: proNotifier.proProfileUrl,
            toUserName: proNotifier.proName,
            projectName: projectNotifer.projectName,
            estimateBookingId: projectNotifer.estimateNo,
            projectStartedOn: projectNotifer.projectStartDate,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Customer Support Button
              Stack(
                children: [
                  InkWell(
                    onTap: _onTapCustomerButton,
                    child: Container(
                      width: w / 2.15,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAEAEA),
                        borderRadius: BorderRadius.circular(w / 12),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: w / 35,
                        vertical: h / 80,
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/icons/support.png"),
                          SizedBox(width: w / 40),
                          MyTextPoppines(
                            text: "Customer Support",
                            height: 1.8,
                            fontSize: w / 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // WWhen support is active we will show a active status
                  isSupportActive
                      ? Positioned(
                          right: w / 200000,
                          child: CircleAvatar(
                            radius: w / 60,
                            backgroundColor:
                                const Color.fromARGB(255, 0, 255, 106),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              // Project Notes Button
              InkWell(
                onTap: _onTapProjectNotesButton,
                child: Container(
                  width: w / 2.5,
                  height: h / 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8EC),
                    borderRadius: BorderRadius.circular(w / 12),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: w / 35,
                    vertical: h / 80,
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icons/writing.png"),
                      SizedBox(width: w / 40),
                      MyTextPoppines(
                        text: "Project Notes",
                        fontSize: w / 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          15.vs,
          // Message pro and Request additional work
          _buildIconButtonWithText(
            firstButtonText: "Message pro",
            firstButtonTextColor: AppColors.buttonBlue,
            firstButtonImgUrl: "assets/icons/customer-support.png",
            firstButtonColor: const Color(0xFFE8F4FF),
            firstButtonOnTap: () => onMessageProTapped(),
            secondButtonext: isProjectCompleted
                ? "   Additional Work   "
                : "Req Additional Work",
            secondtButtonTextColor: const Color(0xFFB9B100),
            secondButtonImgUrl: "assets/icons/add-photo.png",
            secondButtonColor: const Color(0xFFF7F6E0),
            secondButtonOnTap: !isProjectCompleted
                ? () {
                    Navigator.pushNamed(
                      context,
                      AddAdditionalWorkScreen.routeName,
                      arguments: projectId,
                    );
                    print("Project id For additonal work : $projectId");
                  }
                : () {
                    // Show history of all the requested additional work
                    _getAdditionalWorkHandler();
                    Navigator.of(context).pushScreen(
                      AdditionalWorkProProvideScreen(),
                    );
                  },
          ),
          15.vs,
          Row(
            children: [
              // Invoice button
              InkWell(
                onTap: () => _getInvoiceHandler(),
                child: Container(
                  width: context.screenWidth / 3.2,
                  decoration: BoxDecoration(
                    color: Color(0xFF934600).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.linked_camera_outlined,
                        size: 18.sp,
                        color: Color(0xFF934600),
                      ),
                      SizedBox(width: w / 40),
                      MyTextPoppines(
                        text: "Invoice",
                        height: 1.8,
                        fontSize: w / 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF934600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: w / 40),
              // Horuly Work details button
              isNormalProject
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ProWorkDetailsDialog();
                          },
                        );
                      },
                      child: Container(
                        width: context.screenWidth / 2.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFE0EAE4),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.linked_camera_outlined,
                              size: 18.sp,
                              color: Color(0xFF004D1E),
                            ),
                            SizedBox(
                              width: w / 40,
                            ),
                            MyTextPoppines(
                              text: "Work Details",
                              height: 1.8,
                              fontSize: w / 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004D1E),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButtonWithText({
    required String firstButtonText,
    required Color firstButtonTextColor,
    required String firstButtonImgUrl,
    required Color firstButtonColor,
    required VoidCallback firstButtonOnTap,
    required String secondButtonext,
    required Color secondtButtonTextColor,
    required String secondButtonImgUrl,
    required Color secondButtonColor,
    required VoidCallback secondButtonOnTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButtonWithText(
          text: firstButtonText,
          textColor: firstButtonTextColor,
          buttonColor: firstButtonColor,
          iconUrl: firstButtonImgUrl,
          isIcon: false,
          vPadding: 12.h,
          hPadding: 15.w,
          borderRadius: 20.r,
          onTap: firstButtonOnTap,
        ),
        IconButtonWithText(
          text: secondButtonext,
          textColor: secondtButtonTextColor,
          buttonColor: secondButtonColor,
          iconUrl: secondButtonImgUrl,
          isIcon: false,
          vPadding: 12.h,
          hPadding: 15.w,
          borderRadius: 20.r,
          onTap: secondButtonOnTap,
        ),
      ],
    );
  }
}
