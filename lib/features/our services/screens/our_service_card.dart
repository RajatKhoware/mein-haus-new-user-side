// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/features/our%20services/screens/our_services_screen.dart';
import 'package:new_user_side/provider/notifiers/our_services_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/buttons/my_buttons.dart';

class OurServicesCard extends StatelessWidget {
  final int index;
  const OurServicesCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.read<OurServicesNotifier>();
    final services = notifier.services.services![index];
    return Container(
      width: width / 1.4,
      margin: EdgeInsets.only(top: height / 80, right: width / 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          1.vspacing(context),
          Container(
            width: width / 1.45,
            height: height / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: AssetImage("assets/images/fixing/fixing_1.png"),
                fit: BoxFit.cover,
              ),
              //  image: DecorationImage(
              //   image: NetworkImage(services.serviceDescImage.toString()),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: width / 35, bottom: height / 120),
                child: MyTextPoppines(
                  text: services.name.toString(),
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontSize: width / 24,
                ),
              ),
            ),
          ),
          1.vspacing(context),
          Divider(thickness: 1.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextPoppines(
                  text: services.description.toString(),
                  maxLines: 2,
                  fontSize: width / 38,
                ),
                4.vspacing(context),
                MyTextPoppines(
                  text: "50 + Top Rated Pro",
                  maxLines: 2,
                  fontSize: width / 35,
                  fontWeight: FontWeight.w600,
                  color: AppColors.golden,
                ),
                2.vspacing(context),
                MyTextPoppines(
                  text: "10 + Years of experience",
                  maxLines: 2,
                  fontSize: width / 35,
                  fontWeight: FontWeight.w600,
                  color: AppColors.golden,
                ),
              ],
            ),
          ),
          6.vspacing(context),
          Align(
            alignment: Alignment.center,
            child: MyBlueButton(
              hPadding: width / 14,
              vPadding: height / 80,
              text: "View Est",
              fontSize: width / 28,
              fontWeight: FontWeight.w600,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  OurServiceScreen.routeName,
                  arguments: index,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
