// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/provider/notifiers/customer_support_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../features/auth/screens/user_details.dart';
import '../../utils/extensions/get_images.dart';
import '../../utils/extensions/show_picked_images.dart';

class CustomerSupportDialog extends StatefulWidget {
  final bool? isQueryRaised;
  const CustomerSupportDialog({
    Key? key,
    this.isQueryRaised = true,
  }) : super(key: key);

  @override
  State<CustomerSupportDialog> createState() => _CustomerSupportDialogState();
}

class _CustomerSupportDialogState extends State<CustomerSupportDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.watch<CustomerSupportNotifier>();

    Future getImages() async {
      await GetImages().pickImages<CustomerSupportNotifier>(context: context);
    }

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: width / 50, vertical: height / 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                2.vspacing(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.person_alt_circle,
                          color: AppColors.black,
                          size: width / 10,
                        ),
                        5.hspacing(context),
                        MyTextPoppines(
                          text: "Customer Support",
                          fontSize: width / 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 60, vertical: height / 140),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.grey.withOpacity(0.4),
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.xmark,
                          color: AppColors.black,
                          size: width / 26,
                        ),
                      ),
                    ),
                  ],
                ),
                2.vspacing(context),
                const Divider(thickness: 1.0, height: 0.0),
                1.vspacing(context),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 80),
                  color: AppColors.yellow.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextPoppines(
                        text: "Furniture Fixing",
                        fontSize: width / 28,
                        fontWeight: FontWeight.w500,
                      ),
                      MyTextPoppines(
                        text: "OD-79E9646",
                        fontSize: width / 35,
                        color: AppColors.yellow,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                1.5.vspacing(context),
                const Divider(thickness: 1.0, height: 0.0),
                4.vspacing(context),
                widget.isQueryRaised!
                    ? _buildPerQueryDisplayBox(context)
                    : SizedBox(),
                2.vspacing(context),
                MyTextField(
                  text: "Enter Your query below..",
                  maxLines: 4,
                  hintText: "Hi Team What If I Want Another Pro..",
                  isHs20: false,
                  controller: _controller,
                ),
                6.vspacing(context),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextPoppines(
                        text: "Select Photos To Upload :",
                        fontSize: width / 40,
                        fontWeight: FontWeight.w600,
                      ),
                      InkWell(
                        onTap: () => getImages(),
                        child: Container(
                          width: width / 3.4,
                          height: height / 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 1,
                              color: AppColors.textBlue1E9BD0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyTextPoppines(
                                text: "Select File",
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttonBlue,
                                fontSize: width / 28,
                              ),
                              2.hspacing(context),
                              Icon(
                                Icons.attach_file,
                                color: AppColors.buttonBlue,
                                size: width / 28,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                6.vspacing(context),
                notifier.images.isNotEmpty
                    ? ShowPickedImages<CustomerSupportNotifier>()
                    : SizedBox(),
                const Divider(thickness: 1.0),
                4.vspacing(context),
                Center(
                  child: MyBlueButton(
                    hPadding: width / 6,
                    text: "Send",
                    onTap: () {},
                  ),
                ),
                4.vspacing(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPerQueryDisplayBox(BuildContext context) {
    final width = context.screenWidth;
    final height = context.screenHeight;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.black.withOpacity(0.04),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: width / 40, vertical: height / 85),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextPoppines(
                    text: "Raised Query",
                    fontSize: width / 40,
                    fontWeight: FontWeight.w600,
                  ),
                  MyTextPoppines(
                    text: "[You have raised 3 queries for this Job]",
                    fontSize: width / 40,
                    color: AppColors.yellow,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              2.vspacing(context),
              // Pev Query
              Container(
                color: AppColors.black.withOpacity(0.04),
                margin: EdgeInsets.symmetric(
                    horizontal: width / 90, vertical: height / 130),
                padding: EdgeInsets.symmetric(
                    horizontal: width / 40, vertical: height / 85),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextPoppines(
                          text: "•",
                          fontSize: width / 42,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black.withOpacity(0.6),
                        ),
                        2.hspacing(context),
                        SizedBox(
                          width: width / 1.50,
                          child: MyTextPoppines(
                            text:
                                " I Need some help regarding the tools that this pro is using .Can you please request him to exchange these ....",
                            fontSize: width / 42,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  90.hspacing(context),
                  Container(
                    width: width / 22,
                    height: height / 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: AppColors.buttonBlue,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.buttonBlue,
                        size: width / 40,
                      ),
                    ),
                  ),
                  5.hspacing(context),
                  Container(
                    width: width / 22,
                    height: height / 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: AppColors.buttonBlue,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.buttonBlue,
                        size: width / 40,
                      ),
                    ),
                  ),
                  60.hspacing(context),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.amber.shade600,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 50, vertical: height / 200),
                    child: Center(
                      child: MyTextPoppines(
                        text: "2/3",
                        color: AppColors.white,
                        fontSize: width / 48,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
