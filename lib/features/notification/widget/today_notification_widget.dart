import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';

import 'notification_card_widget.dart';


class TodaysNotificationWidget extends StatelessWidget {
  const TodaysNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: MyTextPoppines(
            text: "TODAY",
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const NotificationCardWidget(
          iconImgUrl: "assets/icons/mobile.png",
          notifiHeading: "You have successfully booked project",
          notifiSubHeading: "Project Booked",
          notifiTime: "2h Ago",
        )
      ],
    );
  }
}
