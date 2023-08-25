import 'package:new_user_side/utils/extensions/extensions.dart';

import '../data/network/network_api_servcies.dart';
import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class EstimateRepository {
  NetworkApiServices services = NetworkApiServices();


  // create starting estimate
  Future<ResponseType> createStartingEstimate(ResponseType body) async {
    try {
      return await services.sendDioRequest(
        url: ApiUrls.registerProject,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // create estimate
  Future<ResponseType> createEstimate(ResponseType body) async {
    try {
      return await services.sendDioRequest(
        url: ApiUrls.estimateGeneration,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // get estimate
  Future<ResponseType> getEstimates() async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.getestimate,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // get ongoing projects
  Future<ResponseType> getOngoingProjects() async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.ongoingProject,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // get projects History
  Future<ResponseType> getProjectsHistory() async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.projectHistory,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // get project details
  Future<ResponseType> getProjectDetails(String id) async {
    try {
      return await services.sendHttpRequest(
        url: Uri.parse("${ApiUrls.getProjectDetails}?project_id=$id"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // get prodetails
  Future<ResponseType> getProDetails(String proId) async {
    try {
      return await services.sendHttpRequest(
        url: Uri.parse("${ApiUrls.getProDetails}?pro_id=$proId"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // progress invoice
  Future<ResponseType> progressInvoice(String id) async {
    id.log();
    try {
      return await services.sendHttpRequest(
        url: Uri.parse("${ApiUrls.progressInvoice}?booking_id=$id"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // toggle service
  Future<ResponseType> toggleServices(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.toggleServices,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // write review
  Future<ResponseType> writeReview(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.writeReview,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }
}
