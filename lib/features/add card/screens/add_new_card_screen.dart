import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/buttons/my_bottom_bar_button.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class AddNewCard extends StatelessWidget {
  static const String routeName = '/addCard';
  const AddNewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: "Add new card"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 280.w,
                  height: 172.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/card.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              30.vs,
              const MyTextPoppines(
                text: "Enter credit card details below.",
                fontWeight: FontWeight.w600,
              ),
              10.vs,
              const MyTextField(
                text: "Card Holder Name",
                isHs20: false,
                headingFontWeight: FontWeight.w500,
              ),
              const MyTextField(
                text: "Card Number",
                isHs20: false,
                headingFontWeight: FontWeight.w500,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextField(
                    text: "Expiry Date",
                    isHs20: false,
                    headingFontWeight: FontWeight.w500,
                    width: 160.w,
                  ),
                  MyTextField(
                    text: "CVV ",
                    isHs20: false,
                    headingFontWeight: FontWeight.w500,
                 
                    width: 160.w,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavWidget(
        hPadding: 50.w,
        text: "Add Card",
        onTap: () {},
      ),
    );
  }
}
