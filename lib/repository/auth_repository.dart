import 'package:new_user_side/data/network/base_api_services.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import '../resources/common/api_url/api_urls.dart';
import '../utils/enum.dart';

class AuthRepositorys {
  NetworkApiServices services = NetworkApiServices();
  BaseApiServices _apiServices = OldNetworkApiServices();

// Sanctum
  Future<ResponseType> sanctum() async {
    try {
      return await services.sendHttpRequest(
        url: Uri.parse("https://meinhaus.ca/sanctum/csrf-cookie"),
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

// Login
  Future<ResponseType> login(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.login,
        method: HttpMethod.post,
        body: body,
        allowUnauthorizedResponse: true,
      );
    } catch (e) {
      throw e;
    }
  }

// Auth
  Future<ResponseType> auth() async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.auth,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

// SignUp
  Future<ResponseType> signUp(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.register,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

// Verify Mobile Number
  Future<ResponseType> verifyPhone(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.verifyMobile,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  // Verify Email
  Future<ResponseType> verifyEmai() async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.verifyEmail,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  // Send OTP Mobile
  Future<ResponseType> sendOTPMobile(MapSS data) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.sendOTPMobile,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  // Resend Otp
  Future<ResponseType> resendOtp(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.resendOtp,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  // Add Phone number
  Future<ResponseType> addPhoneNo(MapSS data) async {
    try {
      return await services.sendHttpRequest(
        url: ApiUrls.addMobileNo,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

// User Details
  Future<ResponseType> userDetails(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.userDetails,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  // Social Login
  Future<ResponseType> googleLogin(MapSS data) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.google,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      throw e;
    }
  }

  // Forget Password
  Future<ResponseType> forgetPassword(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.forgetPassword,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Verify Forget Password OTP
  Future<ResponseType> verifyForgetPassOTP(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.verifyForgetPasswordOTP,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Create New password via Forget Password
  Future<ResponseType> createNewPasswordViaFP(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.createNewPasswordViaFP,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      throw e;
    }
  }

  // Resend Forget Password OTP
  Future<ResponseType> resendFOrgetPassOTP(MapSS body) async {
    try {
      return await services.sendHttpRequestWithoutToken(
        url: ApiUrls.resendForgetPasswordOTP,
        method: HttpMethod.post,
        body: body,
        allowUnauthorizedResponse: true,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> google(ResponseType data) async {
    try {
      return await _apiServices.postApiWithoutHeader(ApiUrls.google, data);
    } catch (e) {
      throw e;
    }
  }
}
