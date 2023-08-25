// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/validator.dart';
import '../widgets/auth_textfield.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  // Making the request for forgetpassword will are sharing email so that
  // i can share otp on email and we can verify it for genrate new password
  Future<void> forgetPassword() async {
    final notifier = context.read<AuthNotifier>();
    MapSS body = {"email": _emailController.text};
    if (_emailFormKey.currentState!.validate()) {
      await notifier.forgetPassword(context: context, body: body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w / 20),
          child: Column(
            children: [
              SizedBox(height: h / 80),
              // Kind of App bar
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: w / 10,
                      height: h / 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w / 40),
                        border: Border.all(
                          width: 1.5,
                          color: AppColors.grey.withOpacity(0.4),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.black,
                        size: w / 26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: w / 4, top: h / 80),
                    child: Image.asset(
                      "assets/logo/home.png",
                      fit: BoxFit.cover,
                      width: w / 5,
                      height: h / 13,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h / 30),
              MyTextPoppines(
                text:
                    "Enter the email so that we can send you an otp to reset your password.",
                fontSize: w / 18,
                fontWeight: FontWeight.w600,
                maxLines: 3,
              ),
              SizedBox(height: h / 40),
              Form(
                key: _emailFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: AuthTextField(
                  controller: _emailController,
                  headingText: 'Email',
                  hintText: "email",
                  validator: Validator().validateEmail,
                  isHs20: false,
                ),
              ),
              SizedBox(height: h / 40),
              Divider(thickness: 1.0),
              SizedBox(height: h / 80),
              MyBlueButton(
                hPadding: w / 6,
                text: "Send OTP",
                onTap: () => forgetPassword(),
              )
            ],
          ),
        ),
      ),
    );
  }
}