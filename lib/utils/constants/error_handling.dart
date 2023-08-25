import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../resources/common/my_snake_bar.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnakeBar(context, jsonDecode(response.body)['response_message']);
      break;
    case 401:
      showSnakeBar(context, jsonDecode(response.body)['response_message']);
      break;
    case 500:
      showSnakeBar(context, "Internal Server Error");
      break;
    default:
      showSnakeBar(context, response.body);
  }
}
