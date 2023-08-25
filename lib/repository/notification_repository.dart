import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/resources/common/api_url/api_urls.dart';

import '../utils/enum.dart';

class NotificationRepository {
  NetworkApiServices services = NetworkApiServices();

  Future getNotification() async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.notification,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }
}
