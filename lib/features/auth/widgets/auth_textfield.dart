// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String headingText;
  final String hintText;
  final bool? isEmailField;
  final bool? showSuffix;
  final bool? isHs20;
  final String? Function(String?)? validator;
  const AuthTextField({
    Key? key,
    required this.controller,
    required this.headingText,
    required this.hintText,
    this.isEmailField = true,
    this.showSuffix = true,
    this.isHs20 = true,
    required this.validator,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _showPasswod = false;
  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.isHs20! ? w / 16 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: "  ${widget.headingText}",
            fontSize: w / 28,
            fontWeight: FontWeight.w500,
          ),
          8.vs,
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w / 26),
                borderSide: BorderSide(
                  color: AppColors.black.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w / 26),
                borderSide: BorderSide(
                  color: AppColors.black.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w / 26),
                borderSide: BorderSide(
                  color: Colors.red.shade200,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w / 26),
                borderSide: BorderSide(
                  color: Colors.red.shade200,
                  width: 1.5,
                ),
              ),
              hintText: "Enter your ${widget.hintText} here",
              hintStyle: TextStyle(
                fontSize: w / 26,
                color: AppColors.grey.withOpacity(0.5),
              ),
              suffixIcon: widget.showSuffix!
                  ? widget.isEmailField!
                      ? Icon(
                          Icons.alternate_email_rounded,
                          color: AppColors.grey.withOpacity(0.7),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              _showPasswod = !_showPasswod;
                            });
                          },
                          child: Icon(
                            _showPasswod
                                ? Icons.remove_red_eye_outlined
                                : CupertinoIcons.eye_slash,
                            color: AppColors.grey.withOpacity(0.7),
                          ))
                  : null,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 42),
            ),
            validator: widget.validator,
            keyboardType:TextInputType.emailAddress,
            obscureText: widget.isEmailField! ? false : _showPasswod,
          ),
        ],
      ),
    );
  }
}
