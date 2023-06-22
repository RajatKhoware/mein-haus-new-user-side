import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_user_side/data/models/UserModel.dart';
import 'package:new_user_side/local/user_prefrences.dart';
import 'package:new_user_side/repository/auth_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../data/network/network_api_servcies.dart';
import '../../features/auth/screens/otp_validate_screen.dart';
import '../../features/auth/screens/user_details.dart';
import '../../features/home/screens/home_screen.dart';
import '../../res/common/my_snake_bar.dart';

class AuthNotifier extends ChangeNotifier {
  AuthRepositorys repository = AuthRepositorys();
  final prefs = UserPrefrences();

  // variables
  bool _isToggle = false;
  bool _isWaiting = false;
  bool _loading = false;
  bool _gloading = false;
  User _user = User();
  bool _isAuthenticated = false;
  String accessToken = "";

  // getters
  bool get isToggle => _isToggle;
  bool get isWaiting => _isWaiting;
  User get user => _user;
  bool get loading => _loading;
  bool get gLoading => _gloading;
  bool get isAuthenticated => _isAuthenticated;

  // setters
  void setLoadingState(bool state, bool notify) {
    _loading = state;
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

  void setAuthentication(bool isAuth) {
    _isAuthenticated = isAuth;
    notifyListeners();
  }

// Auth
  Future authentication(BuildContext context) async {
    repository.auth().then((response) {
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
      User user = UserModel.fromJson(response).user!;
      if (response['response_message'] == "Unverified User.") {
        Navigator.of(context).pushScreen(
          OtpValidateScreen(
            email: "${user.email}",
            contactNo: "${user.contact}",
          ),
        );
      } else {
        ("User Logged in Successfully ✨").log("Login Notifier");
        setUser(user);
        await prefs.setToken(user.token!);
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      }
      setLoadingState(false, true);
      showSnakeBarr(context, response['response_message'], BarState.Success);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", BarState.Error);
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
      showSnakeBarr(context, response['response_message'], BarState.Success);
      Navigator.of(context).pushScreen(
        OtpValidateScreen(
          email: data["email"]!,
          contactNo: data["phone"]!,
        ),
      );
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", BarState.Error);
      ("$error  $stackTrace").log(" SignUp notifier");
      setLoadingState(false, true);
    });
  }

// Verify email
  Future verifyEmail({
    required MapSS body,
    required BuildContext context,
  }) async {
    setLoadingState(true, true);
    repository.verifyEmail(body).then((response) async {
      setLoadingState(false, true);
      final user = UserModel.fromJson(response).user!;
      (user).log("Verify otp");
      UserPrefrences().setToken(user.token.toString());
      setUser(user);
      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (route) => false,
      );
      showSnakeBarr(context, response['response_message'], BarState.Success);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", BarState.Error);
      ("$error  $stackTrace").log(" Verify email notifier");
      setLoadingState(false, true);
    });
  }

  //? Submit User Details (OMIT)
  Future submitUserDetails({
    required BuildContext context,
    required MapSS body,
  }) async {
    if (isToggle) {
      setLoadingState(true, true);
      await repository.userDetails(body).then((response) {
        setLoadingState(false, true);
        final user = UserModel.fromJson(response).user!;
        print(user.token);
        UserPrefrences().setToken(user.token.toString());
        setUser(user);
        Navigator.pushNamed(context, HomeScreen.routeName);
      }).onError((error, stackTrace) {
        showSnakeBarr(context, "$error", BarState.Error);
        ("$error  $stackTrace").log(" Verify email notifier");
        setLoadingState(false, true);
      });
    } else
      showSnakeBarr(context, "Please Accept T&C..", BarState.Warning);
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
        BarState.Warning,
      );
      setGoogleLoadingState(false, true);
    }
  }

  // Google Authentication
  Future googleSignIn(BuildContext context) async {
    UserPrefrences pref = await UserPrefrences();
    MapSS data = {"provider": "google", "access_token": accessToken};
    // share the token to backend to get user details
    await repository.googleLogin(data).then((response) async {
      print(response['response_message']);
      if (response['response_message'] == "Signup") {
        await pref.setUserId(response['user_id'].toString());
        (await pref.getUserId()).log("User Id");
        ("Sigup with Google ✅").log("Google-Signup Notifier");
        setGoogleLoadingState(false, true);
        showSnakeBarr(context, "User Sigup with Google", BarState.Success);
        Navigator.pushNamed(context, UserDetailsScreen.routeName);
      } else {
        User user = UserModel.fromJson(response).user!;
        setUser(user);
        await prefs.setToken(user.token!);
        setGoogleLoadingState(false, true);
        ("Login with Google ✅").log("Google-Login Notifier");
        showSnakeBarr(context, "User SignIn with Google", BarState.Success);
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      }
    }).onError((error, stackTrace) {
      setGoogleLoadingState(false, true);
      showSnakeBarr(context, "$error", BarState.Error);
      ("$error  $stackTrace").log("Google Auth notifier");
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
