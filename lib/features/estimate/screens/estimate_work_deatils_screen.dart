// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_user_side/features/check%20out/screens/checkout_screen.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/resources/common/show_img_upload_option.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../resources/common/buttons/my_bottom_bar_button.dart';
import '../widget/download_pdf_card_widget.dart';
import '../widget/estimate_carousel_img.dart';
import '../widget/estimated_work_bill_card_widget.dart';
import '../widget/project_billing_card_widget.dart';
import '../widget/project_estimated_card_widget.dart';

class EstimatedWorkDetailScreen extends StatefulWidget {
  static const String routeName = '/estimatedwork';
  const EstimatedWorkDetailScreen({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<EstimatedWorkDetailScreen> createState() =>
      _EstimatedWorkDetailScreenState();
}

class _EstimatedWorkDetailScreenState extends State<EstimatedWorkDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final getEstProvider = context.watch<EstimateNotifier>();
    final projectDetails =
        getEstProvider.estimated.estimatedWorks![widget.index];
    final bookingId = projectDetails.estimateId;
    final amountToPay = projectDetails.projectBilling!.totalDepositAmount;
    final bool isImgPresent = projectDetails.uploadedImgs!.length > 0;

    return Scaffold(
      appBar: MyAppBar(text: "Estimated Work"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Download PDF
          DownloadPdfCard(workName: projectDetails.projectName ?? ""),
          SizedBox(height: height / 120),
          Divider(thickness: 1.8, height: 0.0),
          SizedBox(height: height / 90),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ESTIMATE NUMBER
                  Row(
                    children: [
                      SizedBox(width: width / 16),
                      MyTextPoppines(
                        text: "Estimate  No :",
                        fontSize: width / 26,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: width / 16),
                      MyTextPoppines(
                        text: projectDetails.estimateId ?? "",
                        fontSize: width / 26,
                        fontWeight: FontWeight.w400,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                  Divider(thickness: 1.8),
                  SizedBox(height: height / 90),
                  // BILL DETAILS
                  EstimatedWorkBillCardWidget(index: widget.index),
                  SizedBox(height: height / 40),
                  Divider(thickness: 1.8),
                  SizedBox(height: height / 40),
                  // SERVICES
                  _buildSubHeadlines(
                    context: context,
                    subHeadline: "Project Estimate :",
                  ),
                  EstimateServiceCardWidget(project: projectDetails),
                  SizedBox(height: height / 90),
                  // PROJECT IMAGES
                  Visibility(
                    visible: isImgPresent,
                    child: _buildSubHeadlines(
                      context: context,
                      subHeadline: "Uploaded Photos :",
                    ),
                  ),
                  Visibility(
                    visible: isImgPresent,
                    child: Column(
                      children: [
                        SizedBox(height: height / 40),
                        EstimateCarouselImg(index: widget.index),
                        SizedBox(height: h / 30),
                      ],
                    ),
                  ),
                  // UPLOAD MORE IMAGES OPTION
                  ShowImgUploadOption(bookingId: bookingId!),
                  SizedBox(height: height / 40),
                  _buildSubHeadlines(
                    context: context,
                    subHeadline: "Project Billing :",
                  ),
                  // PROJECT BILL CARD
                  ProjectBillingCardWidget(index: widget.index)
                ],
              ),
            ),
          ),
        ],
      ),
      // BOOK PROJECT BUTTON
      bottomNavigationBar: MyBottomNavWidget(
        hPadding: width / 7.6,
        text: "Book Project",
        onTap: () {
          Navigator.of(context).pushScreen(
            CheckOutScreen(
              ProjectName: projectDetails.projectName ?? "",
              bookingId: bookingId,
              amountToPay: amountToPay ?? "",
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubHeadlines({
    required BuildContext context,
    required String subHeadline,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(left: width / 22),
      child: MyTextPoppines(
        text: subHeadline,
        fontWeight: FontWeight.w600,
        fontSize: width / 25,
      ),
    );
  }
}
