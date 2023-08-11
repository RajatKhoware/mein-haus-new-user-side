class ApiUrls {
  static String baseUrl = "https://meinhaus.ca/api/";
  //static String baseUrl = "https://meinhaus.ca/meinhaus/api/";

  static Uri setUrls(String uri) {
    return Uri.parse(baseUrl + uri);
  }

  // Auth
  static Uri auth = setUrls("authenticate");
  static Uri login = setUrls("customer/login");
  static Uri register = setUrls("register");
  static Uri verifyEmail = setUrls("email-verification");
  static Uri verifyMobile = setUrls("mobile-verification");
  static Uri sendOTPMobile = setUrls("send-mobile-otp");
  static Uri resendOtp = setUrls("resend-otp");
  static Uri registerProject = setUrls("project-details");
  static Uri addMobileNo = setUrls("customer/add-mobile");
  static Uri google = setUrls("customer-social-login");
  static Uri userDetails = setUrls("user-details");

  // Forget Password
  static Uri forgetPassword = setUrls("send-forgot-password-otp");
  static Uri verifyForgetPasswordOTP = setUrls("verify-forgot-password-otp");
  static Uri createNewPasswordViaFP = setUrls("new-password-with-token");
  static Uri resendForgetPasswordOTP = setUrls("resend-forgot-password-otp");

  // Estimate
  static Uri estimateGeneration = setUrls("estimate-generation");
  static Uri getestimate = setUrls("estimated-work");
  static Uri ongoingProject = setUrls("ongoing-projects");
  static Uri projectHistory = setUrls("projectHistory");
  static String getProjectDetails = "${baseUrl}ongoing-projects/show";
  static String getProDetails = "${baseUrl}show/professional";
  static String progressInvoice = "${baseUrl}progress-invoice";
  static Uri toggleServices = setUrls("toggle-invoice-item");
  static Uri writeReview = setUrls("write-review");

  // Address
  static Uri addAddress = setUrls("add-address");
  static String editAddress = "${baseUrl}edit-addres";
  static Uri deleteAddress = setUrls("delete-address");
  static Uri updateAddress = setUrls("update-address");
  static Uri updateProfile = setUrls("update-profile");
  static Uri updatePassword = setUrls("update-password");

  // Additional Work
  static Uri requestAdditional = setUrls("request-additional-work");
  static String getAdditional = "${baseUrl}get-additional-work";
  static Uri approveAdditional = setUrls("approve-additional-work");
  static Uri rejectAdditional = setUrls("reject-additional-work");

  // Check out
  static Uri checkOut = setUrls("checkout");

  // Saved notes
  static Uri savedNoteForMe = setUrls("add-project-notes-for-me");
  static Uri savedNoteForMeAndPro = setUrls("add-project-notes-for-me-pro");
  static String getSavedNotes =
      "${baseUrl}get-saved-notes?estimate_service_id=";

  // Our servies
  static Uri ourServices = setUrls("get-services");

  // Customer support
  static Uri sendQuery = setUrls("send-query-to-support");
  static String getRaisedQuery = baseUrl + "raised-query?project_id=";
  static Uri keepOpen = setUrls("send-deny-response");
  static Uri acceptAndClose = setUrls("accept-close-request");

  // Upload Img
  static Uri uploadImg = setUrls("upload-img");

  // Stripe
  static String createIntent = baseUrl + "book-project?booking_id=";

  // Pusher-Chat
  static Uri broadcastAuth =
      Uri.parse("https://meinhaus.ca/meinhaus/broadcasting/auth");
  static Uri allConversation = setUrls("all-conversations");
  static Uri loadMessages = setUrls("load-messages");
  static Uri loadMoreMessages = setUrls("load-more");
  static Uri readMessage = setUrls("trigger-read-event");
  static Uri sendMessage = setUrls("send-message");

  // Notification
  static Uri notification = setUrls("read-notifications");
}
