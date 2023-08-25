// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../data/models/generated_estimate_model.dart';
import '../../../provider/notifiers/estimate_notifier.dart';

class ProjectEstimatedCardWidget extends StatelessWidget {
  final EstimatedWorks project;
  const ProjectEstimatedCardWidget({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: project.projectEstimate!.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _BuildServiceCard(
          service: project.projectEstimate![index],
          project: project,
        );
      },
    );
  }
}

class _BuildServiceCard extends StatefulWidget {
  final EstimatedWorks project;
  final ProjectEstimate service;
  const _BuildServiceCard({
    Key? key,
    required this.project,
    required this.service,
  }) : super(key: key);

  @override
  State<_BuildServiceCard> createState() => __BuildServiceCardState();
}

class __BuildServiceCardState extends State<_BuildServiceCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final projectEstimate = widget.project;
    final service = widget.service;
    final servicesLength = projectEstimate.projectEstimate!.length;

    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: width / 14, vertical: height / 40),
      padding:
          EdgeInsets.symmetric(horizontal: width / 22, vertical: height / 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 22),
        color: AppColors.white,
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyTextPoppines(
                text: "Project Area :",
                fontWeight: FontWeight.w600,
                fontSize: width / 28,
              ),
              SizedBox(width: width / 22),
              MyTextPoppines(
                text: service.projectArea ?? "",
                fontSize: width / 30,
              ),
            ],
          ),
          SizedBox(height: height / 80),
          MyTextPoppines(
            text: "Description ",
            fontWeight: FontWeight.w600,
            fontSize: width / 28,
          ),
          SizedBox(height: height / 80),
          Padding(
            padding: EdgeInsets.only(left: width / 30),
            child: MyTextPoppines(
              text: service.projectDescription ?? "No Description",
              fontSize: height / 65,
              maxLines: 100,
              height: 1.4,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: height / 60),
          Row(
            children: [
              MyTextPoppines(
                text: "Desposit Amount :",
                fontSize: width / 28,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(width: width / 22),
              MyTextPoppines(
                text: "\$${service.depositAmount}",
                fontSize: width / 30,
                fontWeight: FontWeight.w600,
                color: AppColors.yellow,
              ),
            ],
          ),
          SizedBox(height: height / 60),
          Row(
            children: [
              MyTextPoppines(
                text: "Project Cost :",
                fontSize: width / 28,
                fontWeight: FontWeight.w600,
              ),
              20.hs,
              MyTextPoppines(
                text: "\$${service.projectCost}",
                fontSize: width / 30,
                fontWeight: FontWeight.w600,
                color: AppColors.yellow,
              ),
            ],
          ),
          SizedBox(height: height / 40),
          Visibility(
            visible: servicesLength > 1,
            child: _BuildButton(service: service),
          )
        ],
      ),
    );
  }
}

class _BuildButton extends StatefulWidget {
  final ProjectEstimate service;

  const _BuildButton({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  State<_BuildButton> createState() => __BuildButtonState();
}

class __BuildButtonState extends State<_BuildButton> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final service = widget.service;
    int status = service.status!;
    int projectId = service.projectId!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextPoppines(
          text: "Action :",
          fontSize: width / 28,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(width: width / 22),
        InkWell(
          onTap: () => _handleTapAction(status, projectId),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width / 22),
            padding: EdgeInsets.symmetric(
                horizontal: width / 22, vertical: height / 120),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: _getStatusColor(status),
              boxShadow: buttonShadow,
            ),
            child: MyTextPoppines(
              text: _getStatusText(status),
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              fontSize: width / 32,
            ),
          ),
        )
      ],
    );
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0:
        return const Color(0xFF00FF00); // Green color for status 1
      case 1:
        return const Color(0xFFFE2828); // Red color for status 0
      case 2:
        return const Color(0xFFFFFF00); // Yellow color for status 2
      default:
        return Colors.grey; // Default color for unknown status
    }
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return "Add Service"; // Text "Remove" for status 0
      case 1:
        return "Remove Service"; // Text "Add" for status 1
      case 2:
        return "Paid"; // Text "Paid" for status 2
      default:
        return "Unknown"; // Default text for unknown status
    }
  }

  _handleTapAction(int status, int id) {
    switch (status) {
      case 0:
        _toggleService(id);
        break;
      case 1:
        _toggleService(id);
        break;
      case 2:
        () {};
        break;
      default:
        break;
    }
  }

  Future _toggleService(id) async {
    final notifier = context.read<EstimateNotifier>();
    MapSS body = {"project_id": id.toString()};
    await notifier.toggleService(context: context, body: body);
  }
}
