// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/features/pro%20profile/view/widget/pro_profile_widget.dart';
import 'package:new_user_side/features/review/widgets/show_review_card.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/auth_notifier.dart';
import '../../../resources/common/show_img_upload_option.dart';
import '../../estimate/widget/download_pdf_card_widget.dart';
import '../widget/ongoing_project_bill_card_widget.dart';
import '../widget/ongoing_project_button_panel.dart';
import '../widget/ongoing_project_desc_card_widget.dart';
import '../widget/ongoing_project_photos_card_widget.dart';

class OngoingProjectDetailScreen extends StatefulWidget {
  final String serviceId;
  static const String routeName = '/ongoingProjectDeatils';
  const OngoingProjectDetailScreen({
    Key? key,
    required this.serviceId,
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
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return services != null && notifier.proDetails.prodata != null
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              appBar: MyAppBar(
                text: services.isCompleted!
                    ? "Project History"
                    : services.normal!
                        ? "Ongoing Job"
                        : "Hourly Job",
              ),
              body: Column(
                children: [
                  DownloadPdfCard(workName: services.projectName.toString()),
                  SizedBox(height: height / 120),
                  Divider(thickness: height * 0.003, height: 0.0),
                  SizedBox(height: height / 60),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ESTIMATE NUMBER
                          Row(
                            children: [
                              SizedBox(width: width / 12),
                              MyTextPoppines(
                                text: "Estimate  No :",
                                fontSize: width / 28,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(width: width / 20),
                              MyTextPoppines(
                                text: services.estimateNo ?? "",
                                fontSize: width / 28,
                                fontWeight: FontWeight.w400,
                                color: AppColors.yellow,
                              ),
                            ],
                          ),
                          Divider(thickness: height * 0.003),
                          SizedBox(height: height / 90),
                          // BILL CARD
                          const OngoingProjectBillCardWidget(),
                          SizedBox(height: height / 90),
                          Divider(thickness: height * 0.003),
                          SizedBox(height: height / 90),
                          // DESCRIPTION
                          const OngoingProjectDescCardWidget(),
                          Divider(thickness: height * 0.003),
                          Visibility(
                            visible: services.projectImages!.length > 0,
                            child: Column(
                              children: [
                                SizedBox(height: height / 90),
                                const OngoingProjectPhotoCardWidget(),
                              ],
                            ),
                          ),
                          SizedBox(height: height / 30),
                          // UPLOAD MORE IMAGES OPTION
                          ShowImgUploadOption(bookingId: services.estimateNo!),
                          SizedBox(height: height / 100),
                          Divider(thickness: height * 0.003),
                          // BUTTONS
                          OngoingJobsButtonsPanel(),
                          Visibility(
                            visible: services.isCompleted!,
                            child: Divider(thickness: height * 0.003),
                          ),
                          Visibility(
                            visible: services.isCompleted!,
                            child: ShowReviewCard(),
                          ),
                          Divider(thickness: height * 0.003),
                          ProProfileWidget(),
                          SizedBox(height: height / 40),
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
