// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_user_side/features/estimate/screens/estimate_work_deatils_screen.dart';
import 'package:new_user_side/features/home/widget/project_img_card_widget.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/static%20components/empty%20states/no_est_view_home_screen.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';

class EstimateCardHomeScreenView extends StatelessWidget {
  final Function(BuildContext context) effect;
  const EstimateCardHomeScreenView({super.key, required this.effect});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final estimateNotifier = context.watch<EstimateNotifier>();
    final estimateWork = estimateNotifier.estimated.estimatedWorks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextPoppines(
          text: "Estimated Work",
          fontWeight: FontWeight.w600,
          fontSize: width / 23,
        ),
        SizedBox(height: height / 70),
        estimateWork != null
            ? Visibility(
                visible: estimateWork.length != 0,
                child: SizedBox(
                  height: height / 3,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: estimateWork.length,
                    itemBuilder: (context, index) {
                      return EstimatedWorkCard(index: index);
                    },
                  ),
                ),
              )
            : effect(context),
        Visibility(
          visible: estimateWork != null && estimateWork.length == 0,
          child: NoEstViewHomeScreenWidget(
            text:
                "You Don’t have any estimated project right now. Add new project",
          ),
        ),
      ],
    );
  }
}

class EstimatedWorkCard extends StatelessWidget {
  final int index;
  const EstimatedWorkCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final getEstProvider = context.watch<EstimateNotifier>();
    final projectDetails = getEstProvider.estimated.estimatedWorks![index];
    final projectCost = projectDetails.projectEstimate![0].projectCost;

    return Container(
      width: width / 2,
      margin: EdgeInsets.only(right: width / 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 28),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width / 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 60),
                // PROJECT NAME
                MyTextPoppines(
                  text: projectDetails.projectName.toString(),
                  fontWeight: FontWeight.w500,
                  fontSize: width / 30,
                ),
                Divider(thickness: 1.0, color: AppColors.grey.withOpacity(0.2)),
                // ESTIMATE DATE
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width / 70),
                  padding: EdgeInsets.symmetric(vertical: height / 150),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width / 70),
                    color: AppColors.yellow.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyTextPoppines(
                        text: "Estimate Date :",
                        fontSize: width / 38,
                        fontWeight: FontWeight.w500,
                      ),
                      MyTextPoppines(
                        text: projectDetails.estimateDate ?? "",
                        fontSize: width / 38,
                        fontWeight: FontWeight.w600,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.0, color: AppColors.grey.withOpacity(0.2)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: width / 65,
              left: width / 65,
              bottom: height / 300,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width / 36,
              vertical: height / 80,
            ),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width / 40),
                bottomRight: Radius.circular(width / 40),
              ),
              // BACKGROUND PROJECT IMAGE
              image: projectDetails.uploadedImgs != null &&
                      projectDetails.uploadedImgs!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(
                        projectDetails.uploadedImgs!.first.thumbnailUrl!,
                      ),
                      fit: BoxFit.fill,
                    )
                  : DecorationImage(
                      image: AssetImage("assets/images/room/2(1).png"),
                      fit: BoxFit.fill,
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextPoppines(
                  text: "Photos:",
                  color: AppColors.white,
                  fontSize: width / 36,
                ),
                SizedBox(height: height / 60),
                // Project Images
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProjectImgCardWidget(
                      width: width / 8,
                      height: height / 16,
                      imgPath: "assets/images/room/2(1).png",
                    ),
                    ProjectImgCardWidget(
                      width: width / 8,
                      height: height / 16,
                      imgPath: "assets/images/room/room_3.png",
                    ),
                    Stack(
                      children: [
                        ProjectImgCardWidget(
                          width: width / 8,
                          height: height / 16,
                          imgPath: "assets/images/room/room_1.png",
                        ),
                        Positioned(
                          left: width / 30,
                          top: height / 60,
                          child: MyTextPoppines(
                            text: " +5\nMore",
                            fontSize: width / 38,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height / 60),
                // ESTIMATE COST
                MyTextPoppines(
                  text: "Estimated Amount: \$${projectCost}",
                  fontSize: width / 36,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                ),
                SizedBox(height: height / 120),
                Divider(
                  thickness: 1,
                  color: AppColors.white.withOpacity(0.8),
                  height: 0,
                ),
                SizedBox(height: height / 120),
                Align(
                  alignment: Alignment.center,
                  child: MyBlueButton(
                    hPadding: width / 10,
                    vPadding: height / 120,
                    text: "View Est",
                    fontSize: width / 30,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        EstimatedWorkDetailScreen.routeName,
                        arguments: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
