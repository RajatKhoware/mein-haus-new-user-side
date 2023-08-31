import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_side/features/add%20card/screens/add_new_card_screen.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/static%20components/dialogs/customer_support_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/common/my_snake_bar.dart';
import '../../edit profile/screens/edit_password_scree.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/setting';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: "Settings"),
      body: Column(
        children: [
          SettingCardWidget(),
        ],
      ),
    );
  }
}

class SettingCardWidget extends StatelessWidget {
  const SettingCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.read<AuthNotifier>();
    final user = notifier.user;
    final bool isSocialLogin = user.isSocialLogin!;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: settingCardList.length,
        itemBuilder: (context, index) {
          final list = settingCardList[index];
          return InkWell(
            onTap: () {
              if (index == 3) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const CustomerSupportDialog();
                  },
                );
              } else if (index == 0) {
                isSocialLogin
                    ? showSnakeBarr(
                        context,
                        "Google User can't change password",
                        SnackBarState.Warning,
                      )
                    : context.pushNamedRoute(list[3]);
              } else {
                context.pushNamedRoute(list[3]);
              }
            },
            child: Container(
              width: double.infinity,
              color: AppColors.grey.withOpacity(0.08),
              padding: EdgeInsets.symmetric(
                horizontal: width / 40,
                vertical: height / 80,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: width / 40,
                vertical: height / 140,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width / 16,
                    backgroundColor: AppColors.grey.withOpacity(0.2),
                    child: SvgPicture.asset(list[0]),
                  ),
                  SizedBox(width: width / 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextPoppines(
                        text: list[1],
                        fontSize: width / 26,
                        fontWeight: FontWeight.w600,
                      ),
                      8.vs,
                      MyTextPoppines(
                        text: list[2],
                        fontSize: width / 32,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

List settingCardList = [
  [
    'assets/svgs/settings_password_icon.svg',
    "Password & Security",
    "Change your password",
    EditPasswordScreen.routeName,
  ],
  [
    'assets/svgs/settings_doc_icon.svg',
    "Terms & Condition",
    "know about terms & condition",
    HomeScreen.routeName,
  ],
  // [
  //   'assets/svgs/settings_card_icon.svg',
  //   "Payment Method",
  //   "Add your credit /debit cards",
  //   AddNewCard.routeName,
  // ],
  [
    'assets/svgs/settings_help_icon.svg',
    "Help & Support",
    "Raise a concern or read our FAQs",
    HomeScreen.routeName,
  ],
];
