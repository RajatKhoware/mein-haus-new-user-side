import 'package:flutter/material.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/UserModel.dart';
import '../features/auth/screens/signin_screen.dart';
import '../provider/notifiers/auth_notifier.dart';
import '../resources/common/my_snake_bar.dart';

class UserPrefrences {
  static String? _authToken;
  SharedPreferences? prefs;

// set token
  Future setToken(String authToken) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString('x-auth-token', authToken);
    ("Token Saved --> $authToken").log("Utils Saved Token");
  }

// get token
  Future getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _authToken = await pref.getString('x-auth-token');
    return _authToken;
  }

// print token
  Future<void> printToken() async {
    prefs = await SharedPreferences.getInstance();
    _authToken = prefs!.getString('x-auth-token');
    print(_authToken!);
  }

// set user-id
  Future<void> setUserId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("user_id", id);
  }

// set user
  Future<void> setUser(User user, BuildContext context) async {
    context.read<AuthNotifier>().setUser(user);
  }

// get user-id
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String userId = await preferences.getString("user_id") ?? "";
    return userId;
  }

// get header
  Future<Map<String, String>> getHeader() async {
    prefs = await SharedPreferences.getInstance();
    final String token = await getToken();
    final String xsrf = await getXsrf();
    final header = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'referer': "https://meinhaus.ca",
      'X-XSRF-TOKEN': xsrf,
    };

    return header;
  }

  // post header
  Future<Map<String, String>> xsrfHeader() async {
    prefs = await SharedPreferences.getInstance();
    final String token = await getToken();
    //final String xsrf = await getXsrf();
    final header = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      // 'Cookie': xsrf,
    };
    return header;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('x-auth-token', '');
      Navigator.of(context).pushNamedAndRemoveUntil(
        SignInScreen.routeName,
        (route) => false,
      );
      ("User Log-out .").log("UP Log-out");
    } catch (e) {
      showSnakeBar(context, e.toString());
    }
  }

  // Set Xsrf
  Future setXsrf(String xsrf) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString('xsrf', xsrf);
    xsrf.log();
  }

  // Get Xsrf
  Future getXsrf() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final xsrf = await pref.getString('xsrf');
    return xsrf;
  }
}
