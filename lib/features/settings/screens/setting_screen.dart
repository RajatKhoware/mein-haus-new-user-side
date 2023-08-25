import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      appBar: MyAppBar(text: "Setting"),
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
    final notifier = context.read<AuthNotifier>();
    final user = notifier.user;
    final bool isSocialLogin = user.isSocialLogin!;
    return SizedBox(
      width: double.infinity,
      height: 600.h,
      child: ListView.builder(
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(
                  children: [
                    Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey.withOpacity(0.2),
                        image: DecorationImage(
                          image: AssetImage(list[0]),
                        ),
                      ),
                    ),
                    20.hs,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextPoppines(
                          text: list[1],
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        8.vs,
                        MyTextPoppines(
                          text: list[2],
                          fontSize: 12.sp,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

List settingCardList = [
  [
    'assets/icons/password.png',
    "Password & Security",
    "Change your password",
    EditPasswordScreen.routeName,
  ],
  [
    'assets/icons/help.png',
    "Terms & Condition",
    "know about terms & condition",
    HomeScreen.routeName,
  ],
  [
    'assets/icons/card-edit.png',
    "Payment Method",
    "Add your credit /debit cards",
    AddNewCard.routeName,
  ],
  [
    'assets/icons/help.png',
    "Help & Support",
    "Raise a concern or read our FAQs",
    HomeScreen.routeName,
  ],
];
