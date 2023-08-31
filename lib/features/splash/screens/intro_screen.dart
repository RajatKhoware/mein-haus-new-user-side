import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/local%20db/user_prefrences.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/features/splash/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.8, 1.0),
    ));

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      setState(() {});
    });

    // authenticate();
    auth();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future auth() async {
    final authNotifier = context.read<AuthNotifier>();
    final token = await UserPrefrences().getToken();
    if (token != '') await authNotifier.authentication(context);
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    isAuth = authNotifier.isAuthenticated;
    final Duration duration = const Duration(milliseconds: 2000);
    final bool opacityValue = _opacityAnimation.value == 0;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          AnimatedOpacity(
            duration: duration,
            opacity: opacityValue ? 0.0 : 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/workers/bg_0.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60.h,
            child: SizedBox(
              width: 300.w,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: opacityValue ? 0.0 : 1,
                child: MyTextPoppines(
                  text:
                      "#1 Fastest & Safest way of performing any renovation or repair",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 3000),
            opacity: opacityValue ? 1.0 : 0.0,
            child: isAuth ? HomeScreen() : SplashScreen(),
          ),
          AnimatedPositioned(
            duration: duration,
            top: 150.h,
            child: SlideTransition(
              position: _offsetAnimation,
              child: AnimatedOpacity(
                duration: duration,
                opacity: _opacityAnimation.value,
                child: AnimatedContainer(
                  duration: duration,
                  width: opacityValue ? 500.w : 240.w,
                  height: opacityValue ? 200.h : 110.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/logo/logo_mein_haus.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
