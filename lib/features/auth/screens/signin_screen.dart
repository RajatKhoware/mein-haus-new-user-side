import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/auth/screens/forget_password.dart';
import 'package:new_user_side/features/auth/screens/otp_validate_screen.dart';
import 'package:new_user_side/features/auth/screens/signup_firststep_screen.dart';
import 'package:new_user_side/features/auth/widgets/auth_banner_widget.dart';
import 'package:new_user_side/features/auth/widgets/auth_textfield.dart';
import 'package:new_user_side/features/auth/widgets/social_login_widget.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../utils/extensions/validator.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signin';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Key to validate form
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isWaiting = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future login() async {
    final notifier = context.read<AuthNotifier>();
    Map<String, String> data = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };
    if (_signInFormKey.currentState!.validate()) {
      notifier.login(data, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            const AuthBannerWidget(),
            20.vs,
            // Text fields
            Form(
              key: _signInFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  AuthTextField(
                    controller: _emailController,
                    headingText: 'Email ID',
                    hintText: "email",
                    validator: Validator().validateEmail,
                  ),
                  15.vs,
                  AuthTextField(
                    controller: _passwordController,
                    headingText: 'Password',
                    hintText: "password",
                    validator: Validator().validatePassword,
                    isEmailField: false,
                  ),
                ],
              ),
            ),
            12.vs,
            Align(
              alignment: const Alignment(0.8, 0.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushScreen(ForgetPasswordScreen());
                },
                child: MyTextPoppines(
                  text: "Forget Password ?",
                  fontSize: 15.sp,
                  color: AppColors.textBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            20.vs,
            // Sing In Button
            Divider(thickness: 1.5.w, indent: 10.w, endIndent: 10.w),
            20.vs,
            MyBlueButton(
              isWaiting: notifier.loading,
              hPadding: 120.w,
              text: "Sign In",
              onTap: () => login(),
            ),
            15.vs,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextPoppines(
                  text: "Don't have an account ?",
                  fontSize: 13.sp,
                  color: AppColors.black.withOpacity(0.7),
                ),
                10.hs,
                InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, SignUpStepFirstScreen.routeName),
                  child: MyTextPoppines(
                    text: "Sign up",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlue,
                  ),
                ),
              ],
            ),
            25.vs,
            // Other options for login
            const SocialLoginWidget(),
          ],
        ),
      ),
    );
  }
}
