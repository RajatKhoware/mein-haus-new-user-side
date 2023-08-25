import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import 'my_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Color? textColor;
  final bool? isLogoVis;
  final VoidCallback? onBack;
  MyAppBar({
    Key? key,
    required this.text,
    this.textColor,
    this.isLogoVis = false,
    this.onBack,
  })  : preferredSize = Size.fromHeight(70),
        super(key: key);
  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leadingWidth: width / 6.5,
            leading: Padding(
              padding: EdgeInsets.only(left: width / 20, top: height / 60),
              child: InkWell(
                onTap: onBack ?? () => Navigator.pop(context),
                child: Container(
                  width: width / 10,
                  // height: height / 0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width / 40),
                    border: Border.all(
                      width: 1.5,
                      color: AppColors.grey.withOpacity(0.4),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.black,
                    size: width / 26,
                  ),
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: height / 40),
              child: MyTextPoppines(
                text: text,
                fontSize: width / 18,
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColors.black,
              ),
            ),
            centerTitle: true,
            actions: isLogoVis!
                ? [
                    Padding(
                      padding: EdgeInsets.only(top: height / 40),
                      child: Image.asset(
                        "assets/logo/home.png",
                        scale: 1.5,
                      ),
                    ),
                    SizedBox(width: width / 40),
                  ]
                : [],
          ),
          SizedBox(height: height / 90),
          const Divider(thickness: 1.8, height: 0.0)
        ],
      ),
    );
  }
}
