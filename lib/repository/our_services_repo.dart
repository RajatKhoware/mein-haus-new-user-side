import 'package:new_user_side/data/network/network_api_servcies.dart';

import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class OurServicesRepo {
  NetworkApiServices service = NetworkApiServices();

// Get Our services
  Future<ResponseType> getOurServices() async {
    try {
      return await service.sendHttpRequest(
        url: ApiUrls.ourServices,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }
}
