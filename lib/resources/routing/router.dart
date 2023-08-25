import 'package:flutter/material.dart';
import 'package:new_user_side/features/add%20card/screens/add_new_card_screen.dart';
import 'package:new_user_side/features/additional%20work/screens/add_addition_work_screen.dart';
import 'package:new_user_side/features/additional%20work/screens/additional_work_from_pro_screen.dart';
import 'package:new_user_side/features/address/screens/add_adress_screen.dart';
import 'package:new_user_side/features/auth/screens/signup_firststep_screen.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/features/all%20conversation/screens/all_conversation_screen.dart';
import 'package:new_user_side/features/customer%20support/screens/customer_support_send_query_screen.dart';
import 'package:new_user_side/features/estimate/screens/all_estimate_work_screen.dart';
import 'package:new_user_side/features/estimate/screens/estimate_generation_screen.dart';
import 'package:new_user_side/features/estimate/screens/estimate_work_deatils_screen.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/features/invoice/screens/progess_invoice_screen.dart';
import 'package:new_user_side/features/notification/screens/notification_screen.dart';
import 'package:new_user_side/features/ongoing%20projects/screens/all_ongoing_projects_screen.dart';
import 'package:new_user_side/features/ongoing%20projects/screens/completed_projects_screen.dart';
import 'package:new_user_side/features/our%20services/screens/our_services_screen.dart';
import 'package:new_user_side/features/project%20notes/view/screens/project_notes_screen.dart';
import 'package:new_user_side/features/settings/screens/setting_screen.dart';
import 'package:new_user_side/features/splash/screens/splash_screen.dart';

import '../../features/auth/screens/signin_screen.dart';
import '../../features/edit profile/screens/edit_password_scree.dart';
import '../../features/edit profile/screens/edit_profile_screen.dart';
import '../common/my_text.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignInScreen(),
      );
    case SignUpStepFirstScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpStepFirstScreen(),
      );
    // case SignUpStepSecondScreen.routeName:
    //   var email = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => SignUpStepSecondScreen(email: email),
    //   );
    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case EstimateGenerationScreen.routeName:
      var isNewEstismate = routeSettings.arguments as bool;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EstimateGenerationScreen(
          isNewEstimate: isNewEstismate,
        ),
      );
    case EstimatedWorkDetailScreen.routeName:
      var index = routeSettings.arguments as int;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EstimatedWorkDetailScreen(
          index: index,
        ),
      );
    case AllOngoingProjects.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AllOngoingProjects(),
      );
    case AllEstimatedWorkScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AllEstimatedWorkScreen(),
      );
    case AllConversationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AllConversationScreen(),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotificationScreen(),
      );
    case UserDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const UserDetailsScreen(),
      );
    // case OtpValidateScreen.routeName:
    //   var email = routeSettings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => OtpValidateScreen(email: email),
    //   );
    case EditProfileScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditProfileScreen(),
      );
    case SettingScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SettingScreen(),
      );
    case CompletedProjectsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CompletedProjectsScreen(),
      );
    case AddNewCard.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddNewCard(),
      );
    case EditPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditPasswordScreen(),
      );

    case AddAdditionalWorkScreen.routeName:
      var projectId = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddAdditionalWorkScreen(
          projectId: projectId,
        ),
      );
    case AdditionalWorkProProvideScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdditionalWorkProProvideScreen(),
      );
    case AddAddressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddAddressScreen(),
      );
    case SavedNotesScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SavedNotesScreen(),
      );
    case ProgressInvoiceScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProgressInvoiceScreen(),
      );
    case OurServiceScreen.routeName:
      var index = routeSettings.arguments as int;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OurServiceScreen(
          index: index,
        ),
      );
    case SendQueryScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SendQueryScreen(),
      );
    case AllConversationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AllConversationScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: MyTextPoppines(text: "No routes defined"),
          ),
        ),
      );
  }
}
