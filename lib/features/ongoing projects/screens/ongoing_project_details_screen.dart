// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/data/models/ongoing_project_model.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/features/pro%20profile/view/widget/pro_profile_widget.dart';
import 'package:new_user_side/features/review/widgets/show_review_card.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../provider/notifiers/auth_notifier.dart';
import '../../estimate/widget/download_pdf_card_widget.dart';
import '../widget/ongoing_project_bill_card_widget.dart';
import '../widget/ongoing_project_desc_card_widget.dart';
import '../widget/ongoing_project_photos_card_widget.dart';
import '../widget/ongoing_project_button_panel.dart';

class OngoingProjectDetailScreen extends StatefulWidget {
  final Projects projects;
  final String serviceId;
  static const String routeName = '/ongoingProjectDeatils';
  const OngoingProjectDetailScreen({
    Key? key,
    required this.projects, required this.serviceId,
  }) : super(key: key);

  @override
  State<OngoingProjectDetailScreen> createState() =>
      _OngoingProjectDetailScreenState();
}

class _OngoingProjectDetailScreenState
    extends State<OngoingProjectDetailScreen> {
  late SupportNotifier notifier;
  late EstimateNotifier estimateNotifier;

  @override
  void didChangeDependencies() {
    notifier = context.read<SupportNotifier>();
    estimateNotifier = context.read<EstimateNotifier>();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    setupPusher();
  }

  @override
  void dispose() {
    final serviceId = estimateNotifier.projectDetails.services!.projectId;
    super.dispose();
    notifier.unsubscribe(serviceId.toString()); // Unsubscribing Pusher Channel
  }

  // Subscribing Customer-Proffessinal Chat Channels
  Future setupPusher() async {
    notifier = context.read<SupportNotifier>();
    final userNotifier = context.read<AuthNotifier>().user;
    final userId = userNotifier.userId.toString();
    final channelName = [
      "private-query.${widget.serviceId}.$userId",
      "private-chat.$userId",
    ];
    await notifier.setupPusher(context, channelName);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final projectDetails = notifier.projectDetails;
    final services = projectDetails.services;

    return services != null && notifier.proDetails.prodata != null
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              appBar: MyAppBar(
                text: services.isCompleted!
                    ? "Project History"
                    : services.normal!
                        ? " Ongoing Job"
                        : "Hourly Job",
              ),
              body: Column(
                children: [
                  DownloadPdfCard(workName: services.projectName.toString()),
                  6.vs,
                  Divider(thickness: 1.8.h, height: 0.0),
                  10.vs,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ESTIMATE NUMBER
                          Row(
                            children: [
                              30.hs,
                              MyTextPoppines(
                                text: "Estimate  No :",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              20.hs,
                              MyTextPoppines(
                                text: services.estimateNo ?? "",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.yellow,
                              ),
                            ],
                          ),
                          Divider(thickness: 1.8.h),
                          10.vs,
                          // BILL CARD
                          const OngoingProjectBillCardWidget(),
                          10.vs,
                          Divider(thickness: 1.8.h),
                          10.vs,
                          // DESCRIPTION
                          const OngoingProjectDescCardWidget(),
                          Visibility(
                            visible: services.projectImages!.length > 0,
                            child: Column(
                              children: [
                                Divider(thickness: 1.8.h),
                                10.vs,
                                const OngoingProjectPhotoCardWidget(),
                              ],
                            ),
                          ),
                          20.vs,
                          Divider(thickness: 1.8.h),
                          // BUTTONS
                          OngoingJobsButtonsPanel(projects: widget.projects),
                          Visibility(
                            visible: services.isCompleted!,
                            child: Divider(thickness: 1.8.h),
                          ),
                          Visibility(
                            visible: widget.projects.isCompleted!,
                            child: ShowReviewCard(),
                          ),
                          Divider(thickness: 1.8.h),
                          ProProfileWidget(),
                          20.vs,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : ModalProgressHUD(inAsyncCall: notifier.loading, child: Scaffold());
  }
}
