// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/res/common/my_app_bar.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../data/models/ongoing_project_model.dart';
import '../../../provider/notifiers/estimate_notifier.dart';
import 'ongoing_project_details_screen.dart';

class SubOngoingProjectScreen extends StatelessWidget {
  static const String routeName = '/subOngoingProject';
  final int index;
  final List<Projects> projects;
  const SubOngoingProjectScreen({
    Key? key,
    required this.index,
    required this.projects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final project = projects[index];
    final projectServices = project.services!;
    return Scaffold(
      appBar: MyAppBar(text: "Ongoing projects"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeading(
              heading: project.projectName.toString(),
              totalServices: project.services!.length.toString(),
              context: context,
            ),
            1.vspacing(context),
            _MainCard(project: project),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: project.services!.length,
              itemBuilder: (context, index) {
                return _ServicesCard(
                  index: index,
                  services: projectServices,
                  projects: projects,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading({
    required String heading,
    required String totalServices,
    required BuildContext context,
  }) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w / 28, vertical: h / 78),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyTextPoppines(
            text: heading,
            fontSize: h / 48.8,
            fontWeight: FontWeight.w600,
          ),
          MyTextPoppines(
            text: "$totalServices Services",
            fontSize: h / 52,
            fontWeight: FontWeight.w500,
            color: AppColors.black.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}

class _MainCard extends StatelessWidget {
  final Projects project;
  const _MainCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final width = context.screenWidth;
    final projectCost = project.projectCost;
    final isImgNull = project.projectImages!.length == 0;
    final headline1 = width / 30;

    return Container(
      width: double.infinity,
      margin:
          EdgeInsets.symmetric(horizontal: width / 25, vertical: height / 80),
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
                horizontal: width / 20, vertical: height / 90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xFFEDF6FF),
            ),
            child: Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextPoppines(
                      text: project.projectName.toString(),
                      fontSize: width / 25,
                      fontWeight: FontWeight.w600,
                    ),
                    2.vspacing(context),
                    MyTextPoppines(
                      text: "( Include ${project.services!.length} Services)",
                      fontSize: width / 38,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                  ],
                ),
                // Project Cost container
                Container(
                  width: width / 3.0,
                  margin: EdgeInsets.only(right: width / 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.golden),
                    color: Color(0xFFFFFCF6),
                  ),
                  child: Column(
                    children: [
                      1.vspacing(context),
                      MyTextPoppines(
                        text: "Total Project Cost",
                        fontSize: width / 36,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withOpacity(0.8),
                      ),
                      Divider(
                        thickness: 1,
                        height: 10,
                        color: AppColors.golden.withOpacity(0.6),
                      ),
                      MyTextPoppines(
                        text: "\$${projectCost}",
                        fontSize: width / 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.golden,
                      ),
                      1.vspacing(context),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(thickness: 1.0, height: 5.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                3.vspacing(context),
                // Booking Id
                Row(
                  children: [
                    MyTextPoppines(
                      text: "Booking ID :",
                      fontSize: headline1,
                      fontWeight: FontWeight.w600,
                    ),
                    5.hspacing(context),
                    MyTextPoppines(
                      text: project.estimateNo.toString(),
                      fontSize: headline1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black.withOpacity(0.6),
                    ),
                  ],
                ),
                5.vspacing(context),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextPoppines(
                      text: "Description :",
                      fontSize: headline1,
                      fontWeight: FontWeight.w600,
                    ),
                    5.hspacing(context),
                    SizedBox(
                      width: width / 1.7,
                      child: MyTextPoppines(
                        text:
                            "Officia tempor ipsum in anim in consequat esse excepteur pariatur ex occaecat nulla do. Ipsum est irure qui laborum labore ex excepteur deserunt do fugiat est sint nostrud. Deserunt exercitation sunt excepteur ex exercitation aliqua irure. Aute ullamco labore officia amet eu qui eiusmod pariatur esse aliquip laborum. Sint non pariatur elit nostrud id enim id.",
                        fontSize: width / 40,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black.withOpacity(0.4),
                        maxLines: 100,
                      ),
                    ),
                  ],
                ),
                5.vspacing(context),
                // Photos
                MyTextPoppines(
                  text: "Photos",
                  fontSize: headline1,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black.withOpacity(0.8),
                ),
                3.vspacing(context),
                isImgNull
                    ? MyTextPoppines(
                        text: "     No Img uploaded yet",
                        fontSize: headline1,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonBlue.withOpacity(0.8),
                      )
                    : SizedBox(
                        height: height / 9,
                        width: width / 1.2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: project.projectImages!.length,
                          itemBuilder: (context, index) {
                            final images = project.projectImages![index];
                            return Container(
                              margin: EdgeInsets.only(right: width / 30),
                              padding: EdgeInsets.all(4),
                              width: width / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.golden,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(images),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          5.vspacing(context),
        ],
      ),
    );
  }
}

class _ServicesCard extends StatelessWidget {
  final int index;
  final List<Services> services;
  final List<Projects> projects;
  const _ServicesCard({
    Key? key,
    required this.index,
    required this.services,
    required this.projects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final width = context.screenWidth;
    final service = services[index];
    final headline1 = width / 35;

    final projectId = service.projectId.toString();
    final proId = service.proId.toString();
    final isProAssigned = proId != "null";

    _getProjectDetails() {
      final notifier = context.read<EstimateNotifier>();
      notifier.getProjectDetails(context: context, id: projectId, proId: proId);
    }

    return Container(
      width: double.infinity,
      margin:
          EdgeInsets.symmetric(horizontal: width / 25, vertical: height / 80),
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
            child: MyTextPoppines(
              text: service.serviceName.toString(),
              fontSize: width / 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(thickness: 1.0, height: 5.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 25),
            child: Column(
              children: [
                3.vspacing(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Assigned date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MyTextPoppines(
                              text: "Date Assigned :  ",
                              fontSize: headline1,
                              fontWeight: FontWeight.w500,
                            ),
                            MyTextPoppines(
                              text: service.dateAssigned.toString(),
                              fontSize: headline1,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withOpacity(0.4),
                            ),
                          ],
                        ),
                        4.vspacing(context),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextPoppines(
                              text: "Pro Assigned :  ",
                              fontSize: headline1,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              width: width / 4,
                              child: MyTextPoppines(
                                text: isProAssigned
                                    ? service.proId.toString()
                                    : "No Pro Assigned yet..!!!",
                                fontSize: headline1,
                                fontWeight: FontWeight.w600,
                                color: isProAssigned
                                    ? AppColors.black.withOpacity(0.4)
                                    : Colors.red,
                              ),
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
                        border: Border.all(width: 0.5, color: AppColors.golden),
                        color: AppColors.golden.withOpacity(0.05),
                      ),
                      child: Column(
                        children: [
                          1.vspacing(context),
                          MyTextPoppines(
                            text: "Service Cost",
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
                            text: "\$${service.projectCost}",
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
                2.vspacing(context),
                Divider(thickness: 1.0),
                2.vspacing(context),
                isProAssigned
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OngoingProjectDetailScreen(
                                  id: projectId,
                                  isNormalProject: false,
                                );
                              },
                            ),
                          );
                          _getProjectDetails();
                          ("Project Id:$projectId : Pro Id:$proId").log();
                        },
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
                      )
                    : SizedBox(),
                4.vspacing(context)
              ],
            ),
          )
        ],
      ),
    );
  }
}
