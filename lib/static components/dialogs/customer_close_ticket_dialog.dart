import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/static%20components/dialogs/customer_keep_open_dialog.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../provider/notifiers/support_notifier.dart';

class CustosmerCloseTicketDialog extends StatelessWidget {
  const CustosmerCloseTicketDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;

    // Accept and close query
    Future _acceptAndCloseHandler() async {
      final notifier = context.read<SupportNotifier>();
      await notifier.acceptAndClose(context);
    }

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: h / 2.9,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: w / 30, vertical: h / 40),
        child: Column(
          children: [
            Image.asset(
              "assets/icons/question.png",
              width: w / 1.3,
              height: h / 8,
            ),
            SizedBox(height: h / 40),
            SizedBox(
              width: w / 1.1,
              child: MyTextPoppines(
                text:
                    "Support is requesting to close the ticket. Are you satisfied?",
                fontSize: w / 28,
                height: 1.4,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: h / 30),
            // buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const CustomerSupportKeepOpenDialog();
                      },
                    );
                  },
                  // keep open button
                  child: Container(
                    width: w / 3,
                    height: h / 19,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w / 12),
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: Center(
                      child: MyTextPoppines(
                        text: "Keep Open",
                        fontWeight: FontWeight.w500,
                        fontSize: w / 28,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
                // accept and close button
                MyBlueButton(
                  hPadding: w / 25,
                  vPadding: h / 74,
                  fontSize: w / 28,
                  text: "Accept & Close",
                  onTap: () => _acceptAndCloseHandler(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
