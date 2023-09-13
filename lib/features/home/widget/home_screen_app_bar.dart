import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/features/all%20conversation/screens/all_conversation_screen.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/provider/notifiers/notification_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/chat_with_pro_notifier.dart';
import '../../notification/screens/notification_screen.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatWithProNotifier>();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final conversations = notifier.conversationsList.conversations;
    int totalUnreadMessages = 0;

    // AllConversation
    void navigateToConversationScreen() {
      Navigator.of(context).pushNamed(AllConversationScreen.routeName);
    }

    // Load Notifications
    Future loadNotification() async {
      final notificationNotifier = context.read<NotificationNotifier>();
      await notificationNotifier.getNotifications();
      Navigator.of(context).pushNamed(NotificationScreen.routeName);
    }

    // Counting the total number of unreaded messages
    for (var conversation in conversations ?? []) {
      int unreadCount = conversation.unreadCount!;
      totalUnreadMessages += unreadCount;
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leadingWidth: width / 3,
      leading: Row(
        children: [
          SizedBox(width: width / 28),
          Builder(
            builder: (context) => InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Image.asset(
                "assets/icons/menu.png",
                width: width / 20,
                height: height / 30,
              ),
            ),
          ),
          SizedBox(width: width / 28),
          InkWell(
            onTap: () => Navigator.of(context).pushScreen(HomeScreen()),
            child: Image.asset(
              "assets/logo/home.png",
              scale: 1.8,
              width: width / 10,
              height: height / 25,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      actions: [
        SizedBox(width: width / 24),
        InkWell(
          onTap: () => navigateToConversationScreen(),
          child: BadgeIcon(
            icon: CupertinoIcons.text_bubble,
            text: totalUnreadMessages.toString(),
          ),
        ),
        SizedBox(width: width / 24),
        InkWell(
          onTap: () => loadNotification(),
          child: BadgeIcon(
            icon: CupertinoIcons.bell,
            text: '0',
            badgePosition: -2,
          ),
        ),
        SizedBox(width: width / 40),
      ],
    );
  }
}

class BadgeIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? badgePosition;

  const BadgeIcon({
    super.key,
    required this.icon,
    required this.text,
    this.badgePosition = 0,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width / 12,
      child: Stack(
        children: [
          Positioned(
            top: width / 40,
            left: 0,
            child: Icon(
              icon,
              color: AppColors.black.withOpacity(0.8),
              size: width / 15,
            ),
          ),
          if (text != '0')
            Positioned(
              top: width / 100,
              left: badgePosition,
              child: Container(
                width: width / 9,
                height: height / 55,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 162, 0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: MyTextPoppines(
                    text: text,
                    fontSize: width / 42,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
