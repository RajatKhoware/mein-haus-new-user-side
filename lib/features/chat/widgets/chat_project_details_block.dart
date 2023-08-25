// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class ProjectDetailsBlock extends StatelessWidget {
  final String? projectNmae;
  final String? projectId;
  final String? projectStartedDate;
  const ProjectDetailsBlock({
    Key? key,
    this.projectNmae,
    this.projectId,
    this.projectStartedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      color: Color(0xFFF7A71E).withOpacity(0.15),
      padding: EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w / 2.5,
                child: MyTextPoppines(
                  text: projectNmae ?? "Furniture Fixing",
                  fontSize: w / 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: h / 200),
              MyTextPoppines(
                text: projectId ?? "OD-79E9646",
                fontSize: w / 40,
                color: AppColors.yellow,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          MyTextPoppines(
            text: projectStartedDate != null
                ? "Project Started On : $projectStartedDate"
                : "Project Started On : 15/02/2023",
            fontSize: w / 34,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
