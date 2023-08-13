import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_user_side/data/models/UserModel.dart';
import 'package:new_user_side/features/auth/screens/add_phone_number_screen.dart';
import 'package:new_user_side/features/auth/screens/create_new_password_screen.dart';
import 'package:new_user_side/features/auth/screens/create_starting_project_screen.dart';
import 'package:new_user_side/features/auth/screens/forget_password_otp_verifation_screen.dart';
import 'package:new_user_side/features/auth/screens/signin_screen.dart';
import 'package:new_user_side/features/edit%20profile/screens/edit_profile_screen.dart';
import 'package:new_user_side/local%20db/user_prefrences.dart';
import 'package:new_user_side/repository/auth_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../data/network/network_api_servcies.dart';
import '../../features/auth/screens/otp_validate_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../res/common/my_snake_bar.dart';

class AuthNotifier extends ChangeNotifier {
  AuthRepositorys repository = AuthRepositorys();
  final prefs = UserPrefrences();

  // variabless
  bool _isToggle = false;
  bool _isWaiting = false;
  bool _loading = false;
  bool _loading2 = false;
  bool _gloading = false;
  User _user = User();
  bool _isAuthenticated = false;
  String accessToken = "";

  // getters
  bool get isToggle => _isToggle;
  bool get isWaiting => _isWaiting;
  User get user => _user;
  bool get loading => _loading;
  bool get loading2 => _loading2;
  bool get gLoading => _gloading;
  bool get isAuthenticated => _isAuthenticated;

  // setters
  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setLoading2State(bool state, bool notify) {
    _loading2 = state;
    if (notify) notifyListeners();
  }

  void setGoogleLoadingState(bool state, bool notify) {
    _gloading = state;
    if (notify) notifyListeners();
  }

  void setToggle(bool val) {
    _isToggle = val;
    notifyListeners();
  }

  void setWaiting(bool val) {
    _isWaiting = val;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updateUser() {
    _user;
    notifyListeners();
  }

  void setAuthentication(bool isAuth) {
    _isAuthenticated = isAuth;
    notifyListeners();
  }

// Auth
  Future authentication(BuildContext context) async {
    await repository.auth().then((response) {
      ("Token Verified!🔥").log("Auth-Auth_Notifier");
      prefs.printToken();
      final user = UserModel.fromJson(response).user!;
      setUser(user);
      Navigator.pushNamed(context, HomeScreen.routeName);
    }).onError((error, stackTrace) {
      ("$error").log("Auth notifier");
    });
  }

// Login
  Future login(MapSS data, BuildContext context) async {
    setLoadingState(true, true);
    repository.login(data).then((response) async {
      if (response['response_code'] == "401") {
        showSnakeBarr(
          context,
          "Invalid Email or Password",
          SnackBarState.Error,
        );
        setLoadingState(false, true);
      } else {
        User user = UserModel.fromJson(response).user!;
        setUser(user);
        await prefs.setToken(user.token!);
        if (user.phoneVerified!) {
          ("User Logged in Successfully ✨").log("Login Notifier");
          showSnakeBarr(
            context,
            response['response_message'],
            SnackBarState.Success,
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        } else {
          showSnakeBarr(
            context,
            "Please verify you details first",
            SnackBarState.Warning,
          );
          Navigator.of(context).pushScreen(
            OtpValidateScreen(
              userId: user.userId!,
              contactNo: user.contact!,
              isSkippAble: true,
            ),
          );
        }
        setLoadingState(false, true);
      }
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("Erorr in Login notifier --> $error").log("Auth-Login Notifier");
      setLoadingState(false, true);
    });
  }

// Signup
  Future signUp(MapSS data, BuildContext context) async {
    setLoadingState(true, true);
    repository.signUp(data).then((response) async {
      setLoadingState(false, true);
      (response).log("SignUp Response");
      showSnakeBarr(
          context, response['response_message'], SnackBarState.Success);
      Navigator.of(context).pushScreen(
        OtpValidateScreen(
          userId: response["user_id"],
          contactNo: data["phone"]!,
          isSkippAble: false,
        ),
      );
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log(" SignUp notifier");
      setLoadingState(false, true);
    });
  }

// Verify Phone
  Future verifyPhone({
    required MapSS body,
    required BuildContext context,
    bool isFromSetting = false,
  }) async {
    setLoadingState(true, true);
    repository.verifyPhone(body).then((response) async {
      setLoadingState(false, true);
      final user = UserModel.fromJson(response).user!;
      UserPrefrences().setToken(user.token.toString());
      setUser(user);
      isFromSetting
          ? Navigator.pop(context)
          : Navigator.of(context).pushScreen(CreateStartingProject());
      showSnakeBarr(
          context, response['response_message'], SnackBarState.Success);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log(" Verify phone notifier");
      setLoadingState(false, true);
    });
  }

  // Verify Email
  Future verifyEmail(BuildContext context) async {
    setLoadingState(true, true);
    await repository.verifyEmai().then((response) async {
      setLoadingState(false, true);
      showSnakeBarr(context, "Verification link sent", SnackBarState.Success);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log("Verify email notifier");
      setLoadingState(false, true);
    });
  }

  // Send OTP On Mobile Number
  Future sendOTPOnMobile({
    required MapSS body,
    required BuildContext context,
  }) async {
    setLoadingState(true, true);
    await repository.sendOTPMobile(body).then((response) async {
      setLoadingState(false, true);
      showSnakeBarr(context, "OTP Sent", SnackBarState.Success);
      showDialog(
        context: context,
        builder: (context) {
          return VerifyPhoneNoDialog();
        },
      );
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log("Send OTP Mobile notifier");
      setLoadingState(false, true);
    });
  }

  // Resend OTP For Verification
  Future resendOtp({
    required MapSS body,
    required BuildContext context,
  }) async {
    repository.resendOtp(body).then((response) {
      showSnakeBarr(context, response['response_message'], SnackBarState.Success);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log(" Resend OTP  notifier");
    });
  }

  // Add phone-number if user don't have any
  Future<void> addPhoneNo({
    required MapSS body,
    required BuildContext context,
  }) async {
    setLoadingState(true, true);
    await repository.addPhoneNo(body).then((response) {
      showSnakeBarr(
          context, "Let's verify your phone number", SnackBarState.Info);
      Navigator.of(context).pushScreen(
        OtpValidateScreen(
          userId: int.parse(body['user_id']!),
          contactNo: body['phone']!,
          isSkippAble: true,
        ),
      );
      setLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log(" Add PhoneNo notifier");
      setLoadingState(false, true);
    });
  }

  // Google Authentication
  Future googleAuth(BuildContext context) async {
    setGoogleLoadingState(true, true);
    try {
      // Creating an user with google
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      accessToken = await gAuth.accessToken!;
      if (accessToken.isNotEmpty) googleSignIn(context);
    } catch (e) {
      showSnakeBarr(
        context,
        "Something went wrong try again",
        SnackBarState.Warning,
      );
      setGoogleLoadingState(false, true);
    }
  }

  // Google Authentication Login/Signup
  Future googleSignIn(BuildContext context) async {
    MapSS data = {"provider": "google", "access_token": accessToken};
    await repository.googleLogin(data).then((response) async {
      showSnakeBarr(
        context,
        response['response_message'],
        SnackBarState.Success,
      );
      User user = UserModel.fromJson(response).user!;
      setUser(user);
      await prefs.setToken(user.token!);
      setGoogleLoadingState(false, true);
      if (user.contact == null || user.phoneVerified == false) {
        Navigator.of(context).pushScreen(
          AddPhoneNumberScreen(userId: user.userId.toString()),
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      }
    }).onError((error, stackTrace) {
      setGoogleLoadingState(false, true);
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log("Google Auth notifier");
    });
  }

  // Forget password will send and otp to given email
  Future<void> forgetPassword({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repository.forgetPassword(body).then((value) {
      showSnakeBarr(context, "OTP SENT", SnackBarState.Success);
      setLoadingState(false, true);
      Navigator.of(context).pushScreen(
        ForgetPasswordOtpValidateScreen(email: body['email']!),
      );
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log("Forget password notifier");
      setLoadingState(false, true);
    });
  }

  // Verify forget password otp
  Future<void> verifyForgetPassOTP({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repository.verifyForgetPassOTP(body).then((response) {
      showSnakeBarr(context, "OTP Verified", SnackBarState.Success);
      setLoadingState(false, true);
      Navigator.of(context).pushScreen(
        CreateNewPasswordScreen(passwordToken: response['token']),
      );
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log("Verify forgetpassword OTP notifier");
      setLoadingState(false, true);
    });
  }

  // Resend forget password otp
  Future<void> resendForgetPassOTP({
    required BuildContext context,
    required MapSS body,
  }) async {
    setGoogleLoadingState(true, true);
    await repository.resendFOrgetPassOTP(body).then((response) {
      showSnakeBarr(context, "OTP Sent Again!", SnackBarState.Success);
      setGoogleLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log("Resend forgetpassword OTP notifier");
      setGoogleLoadingState(false, true);
    });
  }

  // Create new password
  Future<void> createNewPasswordViaFP({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    await repository.createNewPasswordViaFP(body).then((response) {
      showSnakeBarr(
        context,
        "New Password has been created login with same credentials!",
        SnackBarState.Success,
      );
      setLoadingState(false, true);
      Navigator.of(context).pushScreen(SignInScreen());
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error  $stackTrace").log("Create-new-password notifier");
      setLoadingState(false, true);
    });
  }

  // Log-out
  Future logout(BuildContext context) async {
    try {
      if (user.isSocialLogin != null) {
        ("Social").log("Log-out");
        final GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.signOut();
        UserPrefrences().logOut(context);
        print('Signed out successfully.');
      } else {
        print("Social login is null");
        ("normal").log("Log-out");
        UserPrefrences().logOut(context);
      }
    } catch (error) {
      ("$error").log("Logout notifier");
    }
  }
}
