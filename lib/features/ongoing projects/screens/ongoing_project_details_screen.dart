// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/pro%20profile/view/widget/pro_profile_widget.dart';
import 'package:new_user_side/features/review/widgets/show_review_card.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/auth_notifier.dart';
import '../../estimate/widget/download_pdf_card_widget.dart';
import '../widget/ongoing_project_bill_card_widget.dart';
import '../widget/ongoing_project_desc_card_widget.dart';
import '../widget/ongoing_project_photos_card_widget.dart';
import '../widget/ongoingjobs_button_panel.dart';

class OngoingProjectDetailScreen extends StatefulWidget {
  final String id;
  final bool isNormalProject;
  static const String routeName = '/ongoingProjectDeatils';
  const OngoingProjectDetailScreen({
    Key? key,
    required this.id,
    required this.isNormalProject,
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
    super.dispose();
    notifier.unsubscribe(widget.id);
  }

  Future setupPusher() async {
    notifier = context.read<SupportNotifier>();
    final userNotifier = context.read<AuthNotifier>().user;
    final userId = userNotifier.userId.toString();
    final channelName = [
      "private-query.${widget.id}.$userId",
      "private-chat.$userId",
    ];
    await notifier.setupPusher(context, channelName);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final projectDetails = notifier.projectDetails;
    final services = projectDetails.services;
    final String projectName = projectDetails.responseMessage.toString();
    final bool isProjetCompleted = projectName == "Hourly Project";

    return services != null && notifier.proDetails.prodata != null
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              appBar: MyAppBar(text: projectName),
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
                                text: services.estimateNo.toString(),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.yellow,
                              ),
                            ],
                          ),
                          Divider(thickness: 1.8.h),
                          10.vs,
                          const OngoingProjectBillCardWidget(),
                          10.vs,
                          Divider(thickness: 1.8.h),
                          10.vs,
                          const OngoingProjectDescCardWidget(),
                          Divider(thickness: 1.8.h),
                          10.vs,
                          const OngoingProjectPhotoCardWidget(),
                          20.vs,
                          Divider(thickness: 1.8.h),
                          OngoingJobsButtonsPanel(
                            isNormalProject: widget.isNormalProject,
                            projectId: widget.id,
                          ),
                          Visibility(
                            visible: isProjetCompleted,
                            child: Divider(thickness: 1.8.h),
                          ),
                          Visibility(
                            visible: isProjetCompleted,
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
