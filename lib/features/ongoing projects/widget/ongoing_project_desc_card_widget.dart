import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';

class OngoingProjectDescCardWidget extends StatelessWidget {
  const OngoingProjectDescCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.watch<EstimateNotifier>();
    final services = notifier.projectDetails.services!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, bottom: height / 90),
          child: MyTextPoppines(
            text: "Description :",
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: width / 20, bottom: height / 90),
          child: MyTextPoppines(
            text: services.discription ??
                'No project description found. This area usually provides details about the project.',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: AppColors.black.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
