import 'package:new_user_side/data/network/network_api_servcies.dart';

import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class CustomerSupportRepo {
  NetworkApiServices service = NetworkApiServices();

// Send Query to support
  Future<ResponseType> sendQuery(ResponseType body) async {
    try {
      return await service.sendDioRequest(
        url: ApiUrls.sendQuery,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Get Raised Query
  Future<ResponseType> getRaisedQuery(String projectId) async {
    try {
      return await service.sendHttpRequest(
        url: Uri.parse("${ApiUrls.getRaisedQuery}$projectId"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // Send deny request ( Keep opne support )
  Future<ResponseType> keepOpen(MapSS body) async {
    try {
      return await service.sendHttpRequest(
        url: ApiUrls.keepOpen,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Accept and close the support chat
  Future<ResponseType> acceptAndClose(MapSS body) async {
    try {
      return await service.sendHttpRequest(
        url: ApiUrls.acceptAndClose,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
  
}
