import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class PreviewChatImages extends StatelessWidget {
  final String imgPath;
  const PreviewChatImages({
    Key? key,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: w / 22,
          ),
        ),
        title: MyTextPoppines(
          text: "Preview Image",
          color: AppColors.white,
          fontSize: w / 22,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: InteractiveViewer(
            minScale: 0.3,
            child: Hero(
              tag: imgPath,
              child: Image.network(
                imgPath,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
