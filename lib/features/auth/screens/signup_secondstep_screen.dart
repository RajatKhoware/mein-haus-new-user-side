// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/features/auth/screens/signin_screen.dart';
import 'package:new_user_side/features/auth/widgets/auth_banner_widget.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/extensions/validator.dart';
import '../widgets/social_login_widget.dart';

class SignUpStepSecondScreen extends StatefulWidget {
  static const String routeName = '/signup-second';
  final String email;
  final String password;
  const SignUpStepSecondScreen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<SignUpStepSecondScreen> createState() => _SignUpStepSecondScreenState();
}

class _SignUpStepSecondScreenState extends State<SignUpStepSecondScreen> {
  // Key to validate form
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  Future<void> signUp() async {
    final phone = _phoneController.text;
    phone.replaceAll("-", "");
    final MapSS data = {
      "email": widget.email,
      "password": widget.password,
      "fullname": _nameController.text,
      "phone": phone,
    };
    final notifier = context.read<AuthNotifier>();
    if (_signUpFormKey.currentState!.validate()) {
      await notifier.signUp(data, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifer = context.watch<AuthNotifier>();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        children: [
          // Banner
          const AuthBannerWidget(isSignIn: false),
          SizedBox(height: height / 40),
          // Text fields
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MyTextPoppines(
                      text: "Step 2     ",
                      fontSize: width / 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Form(
                    key: _signUpFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextPoppines(
                            text: "Full Name",
                            fontSize: width / 26,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: height / 90),
                          _TextField(
                            controller: _nameController,
                            hintText: "Enter your full name here",
                            validator: Validator().nullValidator,
                          ),
                          SizedBox(height: height / 50),
                          MyTextPoppines(
                            text: "Contact Number",
                            fontSize: width / 26,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: height / 90),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.white,
                                  border: Border.all(
                                    color: AppColors.black.withOpacity(0.15),
                                    width: 1.5,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width / 25,
                                  vertical: height / 50,
                                ),
                                child: MyTextPoppines(
                                  text: "+1",
                                  fontSize: width / 25,
                                ),
                              ),
                              SizedBox(width: width / 40),
                              Expanded(
                                child: _TextField(
                                  controller: _phoneController,
                                  hintText: "XXXXXXXXX",
                                  validator: Validator().validateContactNo,
                                  onChange: (value) {
                                    final fv = _formatPhoneNumber(value);
                                    if (fv != _phoneController.text) {
                                      _phoneController.value = TextEditingValue(
                                        text: fv,
                                        selection: TextSelection.collapsed(
                                          offset: fv.length,
                                        ),
                                      );
                                    }
                                  },
                                  inputFormatter: [
                                    LengthLimitingTextInputFormatter(12),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height / 30),
                  // Sing In Button
                  Divider(
                    thickness: 1.5,
                    indent: width / 50,
                    endIndent: width / 50,
                  ),
                  SizedBox(height: height / 50),
                  MyBlueButton(
                    isWaiting: notifer.loading,
                    hPadding: width / 3,
                    text: "Contiune",
                    onTap: () => signUp(),
                  ),
                  SizedBox(height: height / 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextPoppines(
                        text: "Already have an account ?",
                        fontSize: width / 30,
                        color: AppColors.black.withOpacity(0.7),
                      ),
                      SizedBox(width: width / 40),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, SignInScreen.routeName),
                        child: MyTextPoppines(
                          text: "Sign In",
                          fontSize: width / 30,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 30),
                  // Other options for login
                  const SocialLoginWidget(),
                  SizedBox(height: height / 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Contact number formatter
  String _formatPhoneNumber(String value) {
    value = value.replaceAll('-', ''); // Remove existing hyphens
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      if (i == 3 || i == 6) {
        buffer.write('-');
      }
      buffer.write(value[i]);
    }
    return buffer.toString();
  }
}

// Reuseable text field
class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatter;
  final String hintText;
  final String? Function(String?)? validator;
  const _TextField({
    Key? key,
    required this.controller,
    this.onChange,
    this.inputFormatter,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
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
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: w / 26,
              color: AppColors.grey.withOpacity(0.5),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 42),
          ),
          validator: validator,
          onChanged: onChange,
          inputFormatters: inputFormatter,
        ),
      ],
    );
  }
}
