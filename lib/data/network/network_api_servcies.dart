import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../local db/user_prefrences.dart';
import '../../utils/enum.dart';
import '../exception/app_exception.dart';
import 'base_api_services.dart';

typedef MapSS = Map<String, String>;
typedef ResponseType = Map<String, dynamic>;

class OldNetworkApiServices extends BaseApiServices {
  @override
  Future getApiResponse(Uri url) async {
    dynamic responseJson;
    try {
      final res = await http.get(
        url,
        headers: await UserPrefrences().getHeader(),
      );
      responseJson = errorHandling(res);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(Uri url, Map<String, dynamic> data) async {
    dynamic responseJson;
    try {
      http.Response res = await http
          .post(
            url,
            body: data,
            headers: await UserPrefrences().xsrfHeader(),
          )
          .timeout(Duration(seconds: 15));
      responseJson = errorHandling(res);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  Future postApiWithoutHeader(Uri url, Map<String, dynamic> data) async {
    dynamic responseJson;
    try {
      http.Response res = await http.post(url, body: data);
      responseJson = errorHandling(res);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic errorHandling(http.Response response) {
    dynamic responseJson = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
        throw FetchDataException(
            " ${responseJson['response_message']}  ${response.statusCode}");
      case 401:
        throw UnauthorizedException(
            " ${responseJson['response_message']}  ${response.statusCode}");
      case 404:
        throw FetchDataException(
            " ${responseJson['response_message']}  ${response.statusCode}");
      case 500:
        throw InternalSeverException(
            " ${responseJson['response_message']}  ${response.statusCode}");
      default:
        throw FetchDataException(" with status code : ${response.statusCode}");
    }
  }
}

class NetworkApiServices {
  final dio = Dio();

  // SEND HTTP REQUEST WITH HEADER
  Future sendHttpRequest({
    required Uri url,
    required HttpMethod method,
    MapSS? body,
    bool? allowUnauthorizedResponse = false,
  }) async {
    final uri = url;
    if (body != null) (body).log("${uri.path}");
    dynamic responseJson;
    final getHeader = await UserPrefrences().getHeader();
    final xsrfHeader = await UserPrefrences().xsrfHeader();
    try {
      late final http.Request request;
      switch (method) {
        case HttpMethod.get:
          request = http.Request('GET', uri);
          request.headers.addAll(getHeader);
          break;
        case HttpMethod.post:
          request = http.Request('POST', uri);
          if (body != null) {
            request.bodyFields = body;
          }
          request.headers.addAll(xsrfHeader);
          break;
        case HttpMethod.put:
          request = http.Request('PUT', uri);
          request.body = json.encode(body);
          request.headers.addAll(xsrfHeader);
          break;
        case HttpMethod.delete:
          request = http.Request('DELETE', uri);
          if (body != null) {
            request.bodyFields = body;
          }
          request.headers.addAll(xsrfHeader);
          break;
      }

      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
    //  (response.body).log();
      final xsrf = response.headers['set-cookie'];
      await UserPrefrences().setXsrf(xsrf.toString());
      responseJson = errorHandling(response, allowUnauthorizedResponse);
      (response.statusCode).log(response.request!.url.path.toString());
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // SEND HTTP REQUEST WITHOUT HEADER
  Future sendHttpRequestWithoutToken({
    required Uri url,
    required HttpMethod method,
    MapSS? body,
    bool? allowUnauthorizedResponse = false,
  }) async {
    final uri = url;
    if (body != null) (body).log("${uri.path}");
    dynamic responseJson;
    try {
      late final http.Request request;
      switch (method) {
        case HttpMethod.get:
          request = http.Request('GET', uri);
          break;
        case HttpMethod.post:
          request = http.Request('POST', uri);
          if (body != null) {
            request.bodyFields = body;
          }
          break;
        case HttpMethod.put:
          request = http.Request('PUT', uri);
          request.body = json.encode(body);
          break;
        case HttpMethod.delete:
          request = http.Request('DELETE', uri);
          if (body != null) {
            request.bodyFields = body;
          }
          break;
      }
      request.headers.addAll({'Accept': 'application/json'});
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      // (response.body).log();
      responseJson = errorHandling(response, allowUnauthorizedResponse);
      (response.statusCode).log(response.request!.url.path.toString());
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // SNED FILES WITH DIO REQUEST
  Future<dynamic> sendDioRequest({
    required Uri url,
    required HttpMethod method,
    Map<String, dynamic>? body,
  }) async {
    final dio = Dio();
    final getHeader = await UserPrefrences().getHeader();
    final xsrfHeader = await UserPrefrences().xsrfHeader();
    if (body != null) (body).log("${url.path}");
    try {
      late final Response<dynamic> response;
      switch (method) {
        case HttpMethod.get:
          response = await dio.getUri(
            url,
            options: Options(headers: getHeader),
          );
          break;
        case HttpMethod.post:
          response = await dio.postUri(
            url,
            data: FormData.fromMap(body!),
            options: Options(headers: xsrfHeader),
          );
          break;
        case HttpMethod.put:
          response = await dio.putUri(
            url,
            data: FormData.fromMap(body!),
            options: Options(headers: xsrfHeader),
          );
          break;
        case HttpMethod.delete:
          response = await dio.deleteUri(
            url,
            data: FormData.fromMap(body!),
            options: Options(headers: xsrfHeader),
          );
          break;
      }
      (response.statusCode)!.log(response.realUri.path);
      if (response.statusCode == 200 || response.statusCode == 201)
        return response.data;
      else
        ('API call failed').log("${url.path}");
    } on DioException catch (e) {
      if (e.type == DioException.connectionTimeout ||
          e.type == DioException.sendTimeout ||
          e.type == DioException.receiveTimeout) {
        throw FetchDataException("Request Timeout");
      } else if (e.type == DioException.requestCancelled) {
        throw FetchDataException("Request Cancelled");
      } else {
        throw FetchDataException("Error occurred while making the request");
      }
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // ERROR HANDLING
  dynamic errorHandling(
    http.Response response,
    bool? allowUnauthorizedResponse,
  ) {
    final code = response.statusCode;
    dynamic responseJson = code != 500 ? jsonDecode(response.body) : null;
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        throw FetchDataException(
            " ${responseJson['response_message']} ${response.statusCode}");
      case 401:
        if (allowUnauthorizedResponse!) {
          return responseJson;
        } else {
          throw UnauthorizedException(
              " ${responseJson['response_message']} ${response.statusCode}");
        }
      case 404:
        throw FetchDataException(
            " ${responseJson['response_message']} ${response.statusCode}");
      case 500:
        throw InternalSeverException("");
      default:
        throw FetchDataException(" with status code : ${response.statusCode}");
    }
  }
}
