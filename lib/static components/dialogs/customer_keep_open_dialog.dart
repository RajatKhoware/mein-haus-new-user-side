import 'package:flutter/material.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_snake_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:provider/provider.dart';

import '../../features/auth/screens/user_details.dart';

class CustomerSupportKeepOpenDialog extends StatelessWidget {
  const CustomerSupportKeepOpenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SupportNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;

    // keep open support query
    Future _keepOpenHandler() async {
      if (notifier.messageController.text.isNotEmpty) {
        await notifier.keepOpen(context);
      } else {
        showSnakeBarr(context, "Please enter a reason", SnackBarState.Warning);
      }
    }

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: h / 3.25,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: w / 30, vertical: h / 85),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MyTextField(
              text: "Enter the reason for cancellation",
              headingFontWeight: FontWeight.w600,
              maxLines: 6,
              hintText: "Write down the reason here.",
              isHs20: false,
              controller: notifier.messageController,
              validator: Validator().nullValidator,
            ),
            SizedBox(height: h / 85),
            MyBlueButton(
              hPadding: w / 20,
              vPadding: h / 70,
              text: "Submit it",
              fontSize: w / 30,
              onTap: () => _keepOpenHandler(),
            ),
            SizedBox(height: h / 85),
          ],
        ),
      ),
    );
  }
}
