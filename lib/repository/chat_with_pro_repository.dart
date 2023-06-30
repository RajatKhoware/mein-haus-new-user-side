import 'package:new_user_side/data/network/network_api_servcies.dart';
import '../res/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class ChatWithProRepo {
  NetworkApiServices services = NetworkApiServices();

// Get Conversation List
  Future<ResponseType> allConversation(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.allConversation,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

// Load Messages
  Future<ResponseType> loadMessages(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.loadMessages,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
}
