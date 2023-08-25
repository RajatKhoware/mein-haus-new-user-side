import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../features/edit profile/screens/edit_profile_screen.dart';
import '../../provider/notifiers/auth_notifier.dart';
import '../../utils/constants/app_list.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(w / 20),
          bottomRight: Radius.circular(w / 20),
        ),
      ),
      width: w / 1.42,
      child: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/drawer_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: h / 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ExitIcon(),
                SizedBox(height: h / 30),
                _ProfileCard(),
                SizedBox(height: h / 70),
                Divider(thickness: 1.0),
                _ItemList(),
              ],
            ),
          ),
          Positioned(
            bottom: h / 40,
            left: w / 20,
            child: const _LogoutButton(),
          )
        ],
      ),
    );
  }
}

// Exit Icon button
class _ExitIcon extends StatelessWidget {
  const _ExitIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: EdgeInsets.only(left: w / 10),
        child: Container(
          width: w / 11,
          height: w / 11,
          transform: Matrix4.rotationZ(45 * pi / 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w / 40),
            border: Border.all(
              color: AppColors.black,
              width: 1.2,
            ),
          ),
          child: Transform.rotate(
            angle: 45 * pi / 180,
            child: Icon(
              CupertinoIcons.xmark,
              color: AppColors.buttonBlue,
              size: w / 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final h = context.screenHeight;
    final w = context.screenWidth;
    final user = context.watch<AuthNotifier>().user;
    final placeholderImg =
        "https://as1.ftcdn.net/v2/jpg/02/30/60/82/1000_F_230608264_fhoqBuEyiCPwT0h9RtnsuNAId3hWungP.jpg";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: w / 40),
      padding: EdgeInsets.symmetric(vertical: h / 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w / 36),
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: w / 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User first name
              SizedBox(
                width: w / 4,
                child: MyTextPoppines(
                  text: user.firstname.toString(),
                  fontSize: w / 20,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  maxLines: 1,
                ),
              ),
              // User last name
              SizedBox(
                height: h / 30,
                width: w / 4,
                child: MyTextPoppines(
                  text: user.lastname.toString(),
                  fontSize: w / 20,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                ),
              ),
              SizedBox(height: 10),
              MyTextPoppines(
                text: "View and update \nyour profile",
                fontSize: w / 40,
                fontWeight: FontWeight.w600,
                color: AppColors.black.withOpacity(0.6),
                height: 1.5,
              ),
            ],
          ),
          SizedBox(width: w / 25),
          // Profile pic + Edit button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: w / 14,
                backgroundImage: NetworkImage(
                  user.profilePic!.length > 0
                      ? user.profilePic!
                      : placeholderImg,
                ),
              ),
              SizedBox(height: h / 80),
              Container(
                width: w / 3.5,
                height: h / 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w / 40),
                  color: AppColors.black,
                ),
                child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, EditProfileScreen.routeName),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTextPoppines(
                        text: "Edit Profile",
                        fontSize: w / 32,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: w / 28,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: w / 25),
        ],
      ),
    );
  }
}

// Meny list
class _ItemList extends StatelessWidget {
  const _ItemList({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Padding(
      padding: EdgeInsets.only(left: w / 20),
      child: SizedBox(
        width: w / 1.5,
        height: h / 2.0,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: drawerList.length,
          itemBuilder: (context, index) {
            return Container(
              height: h / 30,
              margin: EdgeInsets.symmetric(vertical: h / 70),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    drawerList[index][2],
                    arguments: true,
                  );
                },
                child: Row(
                  children: [
                    Icon(drawerList[index][0], size: w / 18),
                    SizedBox(width: w / 35),
                    MyTextPoppines(
                      text: drawerList[index][1],
                      fontSize: w / 26,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Log out button
class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    // logged out function
    Future _logoutHandler() async {
      final notifier = context.read<AuthNotifier>();
      await notifier.logout(context);
    }

    return InkWell(
      onTap: () => _logoutHandler,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 12),
          color: AppColors.black.withOpacity(0.8),
          boxShadow: buttonShadow,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width / 6.8,
          vertical: height / 55,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.logout_sharp,
              color: AppColors.white,
            ),
            SizedBox(width: width / 35),
            InkWell(
              onTap: () => _logoutHandler(),
              child: MyTextPoppines(
                text: "Log Out",
                fontSize: height / MyFontSize.font18,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
