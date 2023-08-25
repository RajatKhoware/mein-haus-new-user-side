import 'package:new_user_side/data/network/network_api_servcies.dart';

import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class EditProfileRepository {
   NetworkApiServices services = NetworkApiServices();

  // Edit profile

  // Edit password
  Future<ResponseType> editPassword(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.updatePassword,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
}
