import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:new_user_side/firebase_options.dart';
import 'package:new_user_side/data/push_notification_services.dart';
import 'package:new_user_side/resources/routing/router.dart';
import 'package:new_user_side/features/splash/screens/intro_screen.dart';
import 'package:provider/provider.dart';

import 'provider/providers.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationServices().initNotifications();
  Stripe.publishableKey = dotenv.env['stripePublishableKey']!;
  runApp(
    MultiProvider(
      providers: provider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 781),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Mein Haus',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
          navigatorKey: navigatorKey,
          home: const IntroScreen(),
          onGenerateRoute: (settings) => generateRoute(settings),
        );
      },
    );
  }
}
