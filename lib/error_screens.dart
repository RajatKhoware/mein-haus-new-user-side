import 'package:flutter/material.dart';
import 'package:new_user_side/static%20components/errors%20screens/generic_error_screen.dart';
import 'package:new_user_side/utils/constants/app_string.dart';

class ShowError extends StatelessWidget {
  final String error;
  const ShowError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    late final errorScreen;
    if (error.contains("subtype")) {
      errorScreen = GenericErrorScreen(
        svgImg: somethingWentWrongIcon,
        errorHeading: "Json Error",
        errorSubHeading: SubHeading500,
      );
    } else if (error.contains("Internet")) {
      errorScreen = GenericErrorScreen(
        svgImg: serverErrorIcon,
        errorHeading: "No Intenet Connection",
        errorSubHeading: SubHeading500,
      );
    } else if (error.contains("400")) {
      errorScreen = GenericErrorScreen(
        svgImg: error400Icon,
        errorHeading: heading400,
        errorSubHeading: subHeading400,
      );
    } else if (error.contains("404")) {
      errorScreen = GenericErrorScreen(
        svgImg: error404Icon,
        errorHeading: heading404,
        errorSubHeading: subHeading404,
      );
    } else if (error.contains("500")) {
      errorScreen = GenericErrorScreen(
        svgImg: serverErrorIcon,
        errorHeading: heading500,
        errorSubHeading: SubHeading500,
      );
    } else {
      errorScreen = GenericErrorScreen(
        svgImg: somethingWentWrongIcon,
        errorHeading: headingSomethingWentWrong,
        errorSubHeading: subHeadingSomethingWentWrong,
      );
    }
    return errorScreen;
  }
}
