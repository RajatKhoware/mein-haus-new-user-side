import 'package:new_user_side/data/network/network_api_servcies.dart';

import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class AdditionalWorkRepo {
  NetworkApiServices service = NetworkApiServices();

  // Request additional work
  Future<ResponseType> requestAdditionalWork(ResponseType body) async {
    try {
      return await service.sendDioRequest(
        url: ApiUrls.requestAdditional,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Get additional work
  Future<ResponseType> getAdditonalWork(String id) async {
    try {
      return await service.sendHttpRequest(
        url: Uri.parse("${ApiUrls.getAdditional}?estimate_service_id=$id"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // Approve additional work
  Future<ResponseType> approve(MapSS body) async {
    try {
      return await service.sendHttpRequest(
        url: ApiUrls.approveAdditional,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Reject additional work
  Future<ResponseType> reject(MapSS body) async {
    try {
      return await service.sendHttpRequest(
        url: ApiUrls.rejectAdditional,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
}
