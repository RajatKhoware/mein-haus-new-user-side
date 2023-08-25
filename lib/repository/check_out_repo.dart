import 'package:new_user_side/utils/enum.dart';

import '../data/network/network_api_servcies.dart';
import '../resources/common/api_url/api_urls.dart';

class CheckOutRepository {
  NetworkApiServices service = NetworkApiServices();
  Future<dynamic> checkOut(Map<String, String> data) async {
    try {
      final res = await service.sendHttpRequest(
        url: ApiUrls.checkOut,
        method: HttpMethod.post,
        body: data,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }
}
