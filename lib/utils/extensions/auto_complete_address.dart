import 'dart:convert';
import '../constants/constant.dart';
import 'package:http/http.dart' as http;

class AddressAutocomplete {
  static Future<List<dynamic>> getSuggestions(
    String input,
    String sessionToken,
  ) async {
    String request =
        '$googleAddresUrl?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken&components=country:ca';
    var response = await http.get(Uri.parse(request));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
   //   print("addresprint :  $data");
      return data['predictions'];
    } else {
      throw Exception("Failed to load suggestions");
    }
  }
}
