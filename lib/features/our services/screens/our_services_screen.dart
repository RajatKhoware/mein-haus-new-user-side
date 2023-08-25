// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/our_services_notifier.dart';
import '../../../resources/common/buttons/my_bottom_bar_button.dart';

class OurServiceScreen extends StatelessWidget {
  static const String routeName = '/our-services';
  final int index;
  const OurServiceScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.read<OurServicesNotifier>();
    final services = notifier.services.services![index];
    return Scaffold(
      appBar: MyAppBar(text: "Our Services"),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.black,
            padding: EdgeInsets.symmetric(
                vertical: height / 60, horizontal: width / 20),
            child: MyTextPoppines(
              text: services.name.toString(),
              fontSize: width / 22,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height / 80, horizontal: width / 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage("assets/images/fixing/fixing_1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                3.vspacing(context),
                Divider(thickness: 1.0),
                3.vspacing(context),
                MyTextPoppines(
                  text: "Description : ",
                  fontSize: width / 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                3.vspacing(context),
                MyTextPoppines(
                  text: services.description.toString(),
                  fontSize: width / 35,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black.withOpacity(0.6),
                  maxLines: 100,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavWidget(
        hPadding: MediaQuery.of(context).size.width / 7.6,
        text: "Convert Into Estimate",
        onTap: () {},
      ),
    );
  }
}
