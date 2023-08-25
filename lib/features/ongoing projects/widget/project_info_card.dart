// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/data/models/ongoing_project_model.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../screens/multiple_project_services_screen.dart';
import '../screens/ongoing_project_details_screen.dart';

class ProjectInfoCard extends StatelessWidget {
  final int index;
  final List<Projects> projects;
  const ProjectInfoCard({
    Key? key,
    required this.index,
    required this.projects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final ongoingJobs = projects[index];
    final projectId = ongoingJobs.services![0].projectId.toString();
    final proId = ongoingJobs.services![0].proId.toString();
    final headline1 = width / 35;
    final bool isHourlyBooking = ongoingJobs.normal!;
    final bool isMultipleServices = ongoingJobs.services!.length > 1;

    _getProjectDetails() {
      final notifier = context.read<EstimateNotifier>();
      notifier.getProjectDetails(context: context, id: projectId, proId: proId);
    }

    void onViewDetailsTapped() {
      final project = projects[index];
      isMultipleServices
          ? Navigator.of(context).pushScreen(
              MultipleProjectServicesScreen(project: project),
            )
          : {
              Navigator.of(context).pushScreen(
                OngoingProjectDetailScreen(project: project),
              ),
              _getProjectDetails(),
            };
      ("Project Id:$projectId : Pro Id:$proId").log();
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: width / 25,
        vertical: height / 80,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: width / 20, vertical: height / 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xFFEDF6FF),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextPoppines(
                  text: ongoingJobs.projectName.toString(),
                  fontSize: width / 28,
                  fontWeight: FontWeight.w600,
                ),
                1.vspacing(context),
                Visibility(
                  visible: isMultipleServices,
                  child: MyTextPoppines(
                    text: "( Include ${ongoingJobs.services!.length} Services)",
                    fontSize: width / 38,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 1.0, height: 5.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 25),
            child: Column(
              children: [
                3.vspacing(context),
                // Booking Id, Project Started, Project Cost
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Booking Id & Project date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MyTextPoppines(
                              text: "Booking ID :  ",
                              fontSize: headline1,
                              fontWeight: FontWeight.w500,
                            ),
                            MyTextPoppines(
                              text: ongoingJobs.estimateNo.toString(),
                              fontSize: headline1,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withOpacity(0.4),
                            ),
                          ],
                        ),
                        4.vspacing(context),
                        Row(
                          children: [
                            MyTextPoppines(
                              text: "Project Started :  ",
                              fontSize: headline1,
                              fontWeight: FontWeight.w500,
                            ),
                            MyTextPoppines(
                              text: ongoingJobs.projectStartDate.toString(),
                              fontSize: headline1,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withOpacity(0.4),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Project Cost
                    Container(
                      width: width / 3.6,
                      margin: EdgeInsets.only(right: width / 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.golden),
                        color: AppColors.golden.withOpacity(0.05),
                      ),
                      child: Column(
                        children: [
                          1.vspacing(context),
                          MyTextPoppines(
                            text: "Project Cost",
                            fontSize: headline1,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.8),
                          ),
                          Divider(
                            thickness: 1,
                            height: 10,
                            color: AppColors.golden.withOpacity(0.6),
                          ),
                          MyTextPoppines(
                            text: "\$${ongoingJobs.projectCost}",
                            fontSize: headline1,
                            fontWeight: FontWeight.bold,
                            color: AppColors.golden,
                          ),
                          1.vspacing(context),
                        ],
                      ),
                    )
                  ],
                ),
                5.vspacing(context),
                // Photos
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextPoppines(
                      text: "Photos :",
                      fontSize: headline1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                    SizedBox(
                      height: height / 13,
                      width: width / 1.4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: ongoingJobs.projectImages!.length,
                        itemBuilder: (context, index) {
                          final images = ongoingJobs.projectImages![index];
                          return Container(
                            margin: EdgeInsets.only(left: width / 30),
                            width: width / 5.4,
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 0.5,
                                color: AppColors.golden,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(images.thumbnailUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                2.vspacing(context),
                Divider(thickness: 1.0),
                2.vspacing(context),
                // Hourly booking, View details button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Hourly booking
                    Visibility(
                      visible: !isHourlyBooking,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: height / 110, horizontal: width / 35),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color(0xFFB9B100).withOpacity(0.12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.calendar,
                              size: width / 18,
                            ),
                            5.hspacing(context),
                            MyTextPoppines(
                              text: "Hourly Booking",
                              fontSize: headline1,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: AppColors.black.withOpacity(0.8),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // View details button
                    InkWell(
                      onTap: () => onViewDetailsTapped(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 1.5.w,
                            color: AppColors.textBlue1E9BD0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: width / 28,
                          vertical: height / 100,
                        ),
                        child: MyTextPoppines(
                          text: "View Details",
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonBlue,
                          fontSize: headline1,
                        ),
                      ),
                    ),
                  ],
                ),
                4.vspacing(context)
              ],
            ),
          )
        ],
      ),
    );
  }
}
