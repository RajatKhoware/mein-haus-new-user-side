// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class ForgetPasswordOtpValidateScreen extends StatefulWidget {
  static const String routeName = '/forget-password-otp';
  const ForgetPasswordOtpValidateScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  State<ForgetPasswordOtpValidateScreen> createState() =>
      _ForgetPasswordOtpValidateScreenState();
}

class _ForgetPasswordOtpValidateScreenState
    extends State<ForgetPasswordOtpValidateScreen> {
  // Initial otp is blank
  bool isOtpEnterd = false;
  // Storing otp
  late String otp;
  // Initial time for resending otp
  int startTime = 60;
  // Boolen for showing the resend button
  bool showResendButton = false;
  // Timer for otp
  late Timer _timer;
  Color buttonColor = AppColors.buttonBlue.withOpacity(0.0);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the state is disposed
    super.dispose();
  }

  // countdown for otp resending
  void startTimer() {
    final oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (startTime == 0) {
        setState(() {
          timer.cancel();
          showResendButton = true;
        });
      } else {
        setState(() {
          startTime--;
        });
      }
    });
  }

  // verify forget password otp
  Future _verifyForgetPasswordOTP(String OTP) async {
    final notifer = context.read<AuthNotifier>();
    final body = {"email": widget.email, "otp": OTP};
    if (isOtpEnterd)
      await notifer.verifyForgetPassOTP(body: body, context: context);
  }

  // resend otp handler
  void _resendOtpHandler() {
    final notifer = context.read<AuthNotifier>();
    if (showResendButton) {
      final body = {"email": widget.email};
      notifer.resendForgetPassOTP(body: body, context: context);
      startTimer();
      setState(() {
        startTime = 60;
        showResendButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifer = context.watch<AuthNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w / 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w / 30),
                child: Column(
                  children: [
                    SizedBox(height: h / 40),
                    Align(
                      alignment: Alignment.center,
                      child: MyTextPoppines(
                        text: "Let's Verify your Email",
                        fontSize: w / 18,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: h / 30),
                    MyTextPoppines(
                      text:
                          "We’ve sent an text message with an activation code on your email ${widget.email}",
                      fontSize: w / 30,
                      color: AppColors.black.withOpacity(0.7),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: h / 25),
                    // OTP TEXT FIELD
                    OTPTextField(
                      length: 6,
                      width: w,
                      fieldWidth: w / 8,
                      otpFieldStyle: OtpFieldStyle(
                        focusBorderColor: AppColors.black,
                      ),
                      outlineBorderRadius: w / 28,
                      fieldStyle: FieldStyle.box,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      keyboardType: TextInputType.number,
                      contentPadding: EdgeInsets.symmetric(vertical: h / 75),
                      style: TextStyle(
                        fontSize: w / 20,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          buttonColor = AppColors.buttonBlue.withOpacity(
                              (value.isNotEmpty && value.length <= 6)
                                  ? 0.2 * value.length
                                  : 1.0);
                        });
                      },
                      onCompleted: (value) {
                        setState(() => isOtpEnterd = true);
                        setState(() => otp = value);
                        print("otp set" + otp);
                        print("Completed " + value);
                      },
                    ),
                    SizedBox(height: h / 60),
                    // AUTO FETCHING OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyTextPoppines(
                          text: "Auto fetching",
                          fontSize: w / 36,
                          fontWeight: FontWeight.w700,
                          color: AppColors.buttonBlue,
                        ),
                        SizedBox(width: w / 30),
                        LoadingAnimationWidget.inkDrop(
                          color: AppColors.buttonBlue,
                          size: w / 40,
                        ),
                        SizedBox(width: w / 20),
                      ],
                    ),
                    SizedBox(height: h / 20),
                    // RESEND OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextPoppines(
                          text: "I didn't receive a code",
                          fontSize: w / 30,
                          color: AppColors.black.withOpacity(0.6),
                        ),
                        SizedBox(width: w / 60),
                        MyTextPoppines(
                          text: "00:$startTime",
                          fontSize: w / 27,
                          fontWeight: FontWeight.bold,
                          color: AppColors.buttonBlue,
                        ),
                        SizedBox(width: w / 60),
                        InkWell(
                          onTap: _resendOtpHandler,
                          child: MyTextPoppines(
                            text: "Resend",
                            fontSize: w / 27,
                            fontWeight: FontWeight.bold,
                            color: showResendButton
                                ? Colors.black
                                : Colors.grey[300],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: h / 70),
                    const Divider(thickness: 1.5),
                    MediaQuery.of(context).viewInsets.bottom > 0
                        ? SizedBox(height: h / 25)
                        : SizedBox(height: h / 3.4),
                    // Verify otp button
                    InkWell(
                      onTap: () => _verifyForgetPasswordOTP(otp),
                      child: Container(
                        width: w / 2,
                        height: h / 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w / 8),
                          color: buttonColor,
                        ),
                        child: Center(
                          child: notifer.loading
                              ? LoadingAnimationWidget.inkDrop(
                                  color: AppColors.white,
                                  size: w / 26,
                                )
                              : MyTextPoppines(
                                  text: "Verify OTP",
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: w / 22,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
