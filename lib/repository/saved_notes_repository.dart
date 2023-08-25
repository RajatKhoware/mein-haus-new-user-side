import 'package:new_user_side/data/network/network_api_servcies.dart';

import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class SavedNotesRepo {
  NetworkApiServices service = NetworkApiServices();

// Save Note for Me
  Future<ResponseType> savedNoteForMe(ResponseType body) async {
    try {
      return await service.sendDioRequest(
        url: ApiUrls.savedNoteForMe,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

// Save Note for Me and Pro
  Future<ResponseType> savedNoteForMeAndPro(ResponseType body) async {
    try {
      return await service.sendDioRequest(
        url: ApiUrls.savedNoteForMeAndPro,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

// Get Saved Notes
  Future<ResponseType> getSavedNotes(String id) async {
    try {
      return await service.sendHttpRequest(
        url: Uri.parse("${ApiUrls.getSavedNotes}$id"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }
}
