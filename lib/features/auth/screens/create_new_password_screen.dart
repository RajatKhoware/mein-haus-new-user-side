// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';

import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:provider/provider.dart';

import '../../../resources/common/my_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../widgets/auth_textfield.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String passwordToken;
  const CreateNewPasswordScreen({
    Key? key,
    required this.passwordToken,
  }) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _passwordsFormKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confrimPassController = TextEditingController();

  // Creating a new password after forgetting the pervious one
  Future<void> createNewPassword() async {
    final notifier = context.read<AuthNotifier>();
    MapSS body = {
      "token": widget.passwordToken,
      "password": _passwordController.text,
      "password_confirmation": _confrimPassController.text
    };
    if (_passwordsFormKey.currentState!.validate()) {
      await notifier.createNewPasswordViaFP(context: context, body: body);
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
          child: Form(
            key: _passwordsFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                Align(
                  alignment: Alignment.topLeft,
                  child: MyTextPoppines(
                    text: "Create New Password",
                    fontSize: w / 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: h / 30),
                AuthTextField(
                  controller: _passwordController,
                  headingText: 'Password',
                  hintText: "password",
                  validator: Validator().validatePassword,
                  isEmailField: false,
                  isHs20: false,
                ),
                SizedBox(height: h / 30),
                AuthTextField(
                  controller: _confrimPassController,
                  headingText: 'Confrim Password',
                  hintText: "confirm password",
                  isEmailField: false,
                  isHs20: false,
                  validator: (value) => Validator().validateConfirmPassword(
                    value: value,
                    valController: _passwordController.text,
                  ),
                ),
                SizedBox(height: h / 40),
                Divider(thickness: 1.0),
                SizedBox(height: h / 80),
                MyBlueButton(
                  hPadding: w / 6,
                  text: "Reset Password",
                  onTap: () => createNewPassword(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
