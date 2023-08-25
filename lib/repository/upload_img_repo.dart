import '../data/network/network_api_servcies.dart';
import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class UploadImgRepo {
  NetworkApiServices service = NetworkApiServices();

  // Upload Img
  Future<ResponseType> uploadImg(ResponseType body) async {
    try {
      return await service.sendDioRequest(
        url: ApiUrls.uploadImg,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
}
