import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../../static components/empty states/empty_projects_state_widget.dart';
import '../widget/project_info_card.dart';

class CompletedProjectsScreen extends StatefulWidget {
  static const String routeName = '/CompletedProjectsScreen';

  const CompletedProjectsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CompletedProjectsScreen> createState() =>
      _CompletedProjectsScreenState();
}

class _CompletedProjectsScreenState extends State<CompletedProjectsScreen> {
  @override
  void initState() {
    super.initState();
    getProjectsHistory();
  }

  Future<void> getProjectsHistory() async {
    final notifer = context.read<EstimateNotifier>();
    await notifer.getProjectsHistory(context);
  }

  @override
  Widget build(BuildContext context) {
    final notifer = context.watch<EstimateNotifier>();
    final project = notifer.projectsHistory.projects;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return project != null
        ? Scaffold(
            appBar: MyAppBar(text: "Project History"),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                children: [
                  3.vspacing(context),
                  Visibility(
                    visible: project.length != 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: MyTextPoppines(
                        text:
                            "We have record of your last projects .Tap to view details.",
                        fontSize: height / MyFontSize.font16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  4.vspacing(context),
                  Visibility(
                    visible: project.length != 0,
                    child: Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: project.length,
                        itemBuilder: (context, index) {
                          return ProjectInfoCard(
                            index: index,
                            projects: project,
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: project.length == 0,
                    child: EmptyProjectsStateWidget(
                      headline: "You Don’t have any completed\n projects here",
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
