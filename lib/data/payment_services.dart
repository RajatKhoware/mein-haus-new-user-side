import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/local%20db/user_prefrences.dart';
import 'package:new_user_side/resources/common/my_snake_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../resources/common/api_url/api_urls.dart';
 
class MakePayment {
  Map<String, dynamic>? paymentIntent;
  Future<bool> makePayment({
    required BuildContext context,
    required String bookingId,
  }) async {
    try {
      paymentIntent = await createPaymentIntent(bookingId);
      final clientSecret = (paymentIntent!['payment_intent']['client_secret']);
      final customerId = (paymentIntent!['payment_intent']['customer']);
      final ephemeralKey = (paymentIntent!['ephemeralKey']['secret']);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          customerId: customerId,
          customerEphemeralKeySecret: ephemeralKey,
          merchantDisplayName: 'Mein Haus',
        ),
      );
      final res = await displayPaymentSheet(context);
      return res;
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String bookingId) async {
    final headers = await UserPrefrences().getHeader();
    try {
      var response = await http.get(
        Uri.parse('${ApiUrls.createIntent}$bookingId'),
        headers: headers,
      );
      ("Status at Intent Creation : ${response.statusCode}")
          .log("Payment Intent");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (kDebugMode) {
          // help dev to see the output
          print(data['data']['payment_intent']['client_secret']);
          print(data['data']['payment_intent']['customer']);
          print(data['data']['ephemeralKey']['secret']);
        }
        return data['data'];
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> displayPaymentSheet(BuildContext context) async {
    late bool isValueTrue;
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentIntent = null;
        isValueTrue = true;
      }).onError((error, stackTrace) {
        showSnakeBarr(context, "Transcation Declined", SnackBarState.Info);
        isValueTrue = false;
        throw Exception("$error $stackTrace");
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
      isValueTrue = false;
    } catch (e) {
      print('Error Caught in payment sheet ->>> $e');
      isValueTrue = false;
    }
    return isValueTrue;
  }
}
