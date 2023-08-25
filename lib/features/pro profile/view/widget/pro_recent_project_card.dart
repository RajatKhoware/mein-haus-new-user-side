import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/static%20components/dialogs/view_pro_recent_project_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../provider/notifiers/estimate_notifier.dart';

class ProRecentProjectsCardWidget extends StatelessWidget {
  const ProRecentProjectsCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final pro = notifier.proDetails.prodata!.proRecentProjects!;

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 90),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 26),
        color: AppColors.white,
        border: Border.all(
          width: 1.0,
          color: AppColors.black.withOpacity(0.2),
        ),
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          2.5.vspacing(context),
          MyTextPoppines(
            text: "Recent Projects",
            fontSize: width / 28,
            fontWeight: FontWeight.w500,
          ),
          Divider(thickness: 1.0),
          3.vspacing(context),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: pro.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 0.78,
              crossAxisSpacing: width / 40,
              mainAxisSpacing: height / 39,
            ),
            itemBuilder: (context, index) {
              return _buildRecentProjectCard(
                projectTitle: pro[index].projectName.toString(),
                projectImg: "assets/images/room/room_4.png",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ProRecentProjectDialog(index: index);
                    },
                  );
                },
                context: context,
              );
            },
          ),
          5.vspacing(context),
        ],
      ),
    );
  }

  Widget _buildRecentProjectCard({
    required String projectTitle,
    required String projectImg,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final height = context.screenHeight;
    final widthh = context.screenWidth;
    final BorderRadius borderRadius = BorderRadius.circular(widthh / 40);
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(30, 0, 0, 0),
            offset: const Offset(0, 4),
            blurRadius: widthh / 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          1.vspacing(context),
          SizedBox(
            width: widthh / 2.50,
            child: MyTextPoppines(
              text: "  $projectTitle",
              fontSize: widthh / 42,
              fontWeight: FontWeight.w500,
              maxLines: 1,
            ),
          ),
          2.vspacing(context),
          Container(
            width: widthh / 2.50,
            height: height / 8.67,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: AppColors.white,
              image: DecorationImage(
                image: AssetImage(projectImg),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(widthh / 30),
                      bottomLeft: Radius.circular(widthh / 30),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        height: height / 39.05,
                        width: widthh / 2.50,
                        color: AppColors.white.withOpacity(0.2),
                        child: InkWell(
                          onTap: onTap,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "View Deatils",
                                style: GoogleFonts.poppins(
                                  fontSize: widthh / 36,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              Icon(
                                CupertinoIcons.forward,
                                color: AppColors.white,
                                size: widthh / 28,
                              ),
                              4.hspacing(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
