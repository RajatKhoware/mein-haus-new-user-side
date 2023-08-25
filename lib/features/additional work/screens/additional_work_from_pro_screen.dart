// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/provider/notifiers/additional_work_notifier.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/common/my_app_bar.dart';
import '../../../resources/common/my_text.dart';
import '../../estimate/widget/download_pdf_card_widget.dart';
import '../widget/additional_work_pro_provide_card_widget.dart';

class AdditionalWorkProProvideScreen extends StatelessWidget {
  static const String routeName = '/additionalworkprpprovide';
  const AdditionalWorkProProvideScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final additionalNotifier = context.watch<AdditionalWorkNotifier>();
    final estimateNotifier = context.watch<EstimateNotifier>();
    final additionalWork = additionalNotifier.additionalWork.additionalWork!;
    final projectDetails = estimateNotifier.projectDetails.services!;
    return ModalProgressHUD(
      inAsyncCall: additionalNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Additional Works"),
        body: Column(
          children: [
            DownloadPdfCard(
              workName: projectDetails.projectName.toString(),
              isAddonWork: true,
              projectId: projectDetails.estimateNo,
            ),
            const Divider(thickness: 2, height: 9),
            Expanded(
              child: SingleChildScrollView(
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
                      5.vspacing(context),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: additionalWork.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AdditionalWorkProProvideCardWidget(
                            index: index,
                          );
                        },
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
