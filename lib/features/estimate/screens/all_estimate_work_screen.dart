// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../../static components/empty states/empty_projects_state_widget.dart';
import '../widget/all_estimate_work_card.dart';

class AllEstimatedWorkScreen extends StatelessWidget {
  static const String routeName = '/allEstimatedWorks';

  const AllEstimatedWorkScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifer = context.read<EstimateNotifier>();
    final estimate = notifer.estimated.estimatedWorks!;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(text: "Estimated Work's"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            3.vspacing(context),
            Visibility(
              visible: estimate.length != 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: MyTextPoppines(
                  text: "Here’s the list of all estimates.",
                  fontSize: height / MyFontSize.font16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            3.vspacing(context),
            Visibility(
              visible: estimate.length != 0,
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: estimate.length,
                  itemBuilder: (context, index) {
                    return AllEstimateWorkCard(index: index);
                  },
                ),
              ),
            ),
            Visibility(
              visible: estimate.length == 0,
              child: EmptyProjectsStateWidget(
                headline: "You Don’t have any estimate\n projects here",
                svgImg: 'assets/svgs/no_estimate_work.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}
