import '../data/network/network_api_servcies.dart';
import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class AddressRepository {
  NetworkApiServices services = NetworkApiServices();

  // Add address
  Future<ResponseType> addAddress(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.addAddress,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Edit address
  Future<ResponseType> editAdrress(String addressId) async {
    try {
      return await services.sendHttpRequest(
        url: Uri.parse("${ApiUrls.editAddress}id=$addressId"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // Update address
  Future<ResponseType> updateAddress(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.updateAddress,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Delete address
  Future<ResponseType> deleteAddress(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.deleteAddress,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
}
