import 'package:flutter/material.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

// BACK TO HOME BUTTON
class ShowQueryIsFlagged extends StatelessWidget {
  const ShowQueryIsFlagged({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Container(
      width: double.infinity,
      height: h / 4.6,
      margin: EdgeInsets.symmetric(horizontal: w / 12, vertical: h / 25),
      padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: h / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w / 26),
        color: AppColors.yellow,
      ),
      child: Column(
        children: [
          SizedBox(height: 18),
          MyTextPoppines(
            text:
                "Your ticket has been flagged for our escalation team. They will contact you shortly!",
            fontSize: w / 26,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(height: 18),
          MyBlueButton(
            hPadding: w / 10,
            fontSize: w / 26,
            text: "Back To Home",
            onTap: () {
              context.pushNamedRoute(HomeScreen.routeName);
            },
            vPadding: h / 60,
          )
        ],
      ),
    );
  }
}
