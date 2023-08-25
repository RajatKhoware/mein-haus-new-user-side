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
import '../widget/project_info_card.dart';

class AllOngoingProjects extends StatelessWidget {
  static const String routeName = '/allongoing';
  const AllOngoingProjects({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifer = context.read<EstimateNotifier>();
    final ongoingProjects = notifer.ongoingProjects.projects!;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MyAppBar(text: "Ongoing Projects"),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            3.vspacing(context),
            Visibility(
              visible: ongoingProjects.length != 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: MyTextPoppines(
                  text: "Here’s the list of all ongoing projects.",
                  fontSize: height / MyFontSize.font16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            4.vspacing(context),
            Visibility(
              visible: ongoingProjects.length != 0,
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: ongoingProjects.length,
                  itemBuilder: (context, index) {
                    return ProjectInfoCard(
                      index: index,
                      projects: ongoingProjects,
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: ongoingProjects.length == 0,
              child: EmptyProjectsStateWidget(
                headline: "You Don’t have any ongoing\n projects here",
                svgImg: 'assets/svgs/no_ongoing.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}
