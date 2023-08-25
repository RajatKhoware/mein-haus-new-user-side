// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/features/edit%20profile/controller/provider/edit_profile_notifier.dart';
import 'package:new_user_side/features/edit%20profile/controller/services/edit_profile_services.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';

import '../../../resources/common/buttons/my_buttons.dart';
import '../../../static components/dialogs/edit_profile_dialog.dart';
import '../../../utils/extensions/get_images.dart';
import '../../estimate/widget/saved_adresses_widget.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileServices profileServices = EditProfileServices();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  GetImages getImages = GetImages();

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthNotifier>().user;
    firstNameController = TextEditingController(text: user.firstname);
    lastNameController = TextEditingController(text: user.lastname);
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  // Pick Images from gallary
  Future getImagess() async {
    await getImages.pickImage<EditProfileNotifier>(context: context);
  }

  // Editing the User Profile [Name, Pic]
  _editProfileHandler() async {
    final notifier = context.read<EditProfileNotifier>();
    await notifier.editProfile(
      context: context,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
    );
  }

  // This function sent an otp to there registered mobile no
  Future<void> _verifyPhoneNoHandler(String phoneNo) async {
    final notifier = context.read<AuthNotifier>();
    final phone = phoneNo.replaceAll("-", "");
    MapSS body = {"phone": phone};
    await notifier.sendOTPOnMobile(body: body, context: context);
  }

  // This function will send an email with verfication link
  Future<void> _verifyEmailHandler() async {
    final notifier = context.read<AuthNotifier>();
    await notifier.verifyEmail(context);
  }

  ImageProvider<Object> _showProfileImage({
    required String notifierImg,
    required String newtworkImg,
  }) {
    if (notifierImg.isNotEmpty) {
      return Image.file(File(notifierImg)).image;
    } else if (newtworkImg.length != 0) {
      return NetworkImage(newtworkImg);
    } else {
      return AssetImage("assets/images/man.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final user = context.watch<AuthNotifier>().user;
    final notifier = context.watch<EditProfileNotifier>();
    String userName = "${user.firstname} ${user.lastname}";
    final img = notifier.image;

    return ModalProgressHUD(
      inAsyncCall: notifier.loading,
      child: Scaffold(
        // App bar
        appBar: MyAppBar(
          text: "Edit Profile",
          onBack: () {
            notifier.image.path.isNotEmpty
                ? showDialog(
                    context: context,
                    builder: (context) {
                      return EditProfilePicDialog(
                        onTapAtOk: () async {
                          notifier.setProfileImg(XFile(""));
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  )
                : Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            10.vs,
            Row(
              children: [
                30.hs,
                Container(
                  width: width / 4.5,
                  height: height / 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: _showProfileImage(
                        notifierImg: img.path,
                        newtworkImg: user.profilePic!,
                      ),
                    ),
                    border: Border.all(
                      color: AppColors.black,
                      width: width / 200,
                    ),
                  ),
                ),
                20.hs,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.screenWidth / 1.6,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: MyTextPoppines(
                          text: userName,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    10.vs,
                    // Change Profile button
                    InkWell(
                      onTap: () => getImagess(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.textBlue1E9BD0.withOpacity(0.12),
                        ),
                        child: Row(
                          children: [
                            MyTextPoppines(
                              text: "Change Profile",
                              color: AppColors.textBlue1E9BD0,
                              fontSize:
                                  context.screenHeight / MyFontSize.font10,
                              fontWeight: FontWeight.w500,
                            ),
                            10.hs,
                            Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.textBlue1E9BD0,
                              size: 16.sp,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            10.vs,
            Divider(thickness: 1.5, indent: 20.w, endIndent: 20.w),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.vs,
                      // BASIC INFO
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            width: 0.8,
                            color: AppColors.black.withOpacity(0.2),
                          ),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(12, 0, 0, 0),
                              offset: const Offset(0, 4),
                              blurRadius: 10.r,
                              spreadRadius: 2.r,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 5.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            15.vs,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyTextPoppines(
                                  text: "Basic Info",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                MyBlueButton(
                                  hPadding: 20.w,
                                  vPadding: 10.h,
                                  text: "Update Profile",
                                  fontSize: 10.sp,
                                  onTap: () => _editProfileHandler(),
                                ),
                              ],
                            ),
                            10.vs,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                children: [
                                  10.vs,
                                  _TextField(
                                    hText: "First Name",
                                    hintText: user.firstname.toString(),
                                    controller: firstNameController,
                                    onSaved: (val) {},
                                  ),
                                  _TextField(
                                    hText: "Last Name",
                                    hintText: user.lastname.toString(),
                                    controller: lastNameController,
                                    onSaved: (val) {},
                                  ),
                                  _TextField(
                                    hText: "Mobile No",
                                    hintText: "(+1) ${user.contact}",
                                    isEditable: false,
                                    isAuthFields: true,
                                    isVerified: user.phoneVerified,
                                    onVerifyTap: () =>
                                        _verifyPhoneNoHandler(user.contact!),
                                  ),
                                  _TextField(
                                    hText: "Email ID",
                                    hintText: user.email.toString(),
                                    isEditable: false,
                                    isAuthFields: true,
                                    isVerified: user.emailVerified,
                                    onVerifyTap: () => _verifyEmailHandler(),
                                  ),
                                  10.vs,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.vs,
                      Divider(thickness: 1.5, indent: 20.w, endIndent: 20.w),
                      20.vs,
                      const SavedAddressesWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String hText;
  final String hintText;
  final bool? isEditable;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final bool? isAuthFields;
  final bool? isVerified;
  final VoidCallback? onVerifyTap;
  const _TextField({
    Key? key,
    required this.hText,
    required this.hintText,
    this.isEditable = true,
    this.controller,
    this.onSaved,
    this.isAuthFields = false,
    this.isVerified = false,
    this.onVerifyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextPoppines(
                text: hText,
                fontSize: h / MyFontSize.font12,
              ),
              isAuthFields!
                  ? isVerified!
                      ? Icon(
                          Icons.verified,
                          size: w / 20,
                          color: Colors.green,
                        )
                      : InkWell(
                          onTap: onVerifyTap,
                          child: authNotifier.loading
                              ? LoadingAnimationWidget.inkDrop(
                                  color: AppColors.buttonBlue, size: w / 30)
                              : Text(
                                  "Verify",
                                  style: GoogleFonts.poppins(
                                    color: AppColors.buttonBlue,
                                    fontSize: w / 30,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                        )
                  : SizedBox(),
            ],
          ),
          SizedBox(
            height: 35.h,
            child: TextFormField(
              controller: controller,
              enabled: isEditable,
              style: GoogleFonts.poppins(
                fontSize: h / MyFontSize.font12,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10.h),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.grey.withOpacity(0.4),
                    width: 0.7,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.textBlue1E9BD0,
                    width: 0.7,
                  ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(fontSize: h / MyFontSize.font12),
              ),
              onSaved: onSaved,
            ),
          ),
        ],
      ),
    );
  }
}

class VerifyPhoneNoDialog extends StatefulWidget {
  const VerifyPhoneNoDialog({super.key});

  @override
  State<VerifyPhoneNoDialog> createState() => VerifyPhoneNoDialogState();
}

class VerifyPhoneNoDialogState extends State<VerifyPhoneNoDialog> {
  // Initial otp is blank
  bool isOtpEnterd = false;
  // Storing otp
  late String otp;

  // verify phone no handler
  Future _verifyPhoneNoHandler(String OTP) async {
    final notifer = context.read<AuthNotifier>();
    final userId = notifer.user.userId.toString();
    final body = {
      "user_id": userId,
      "otp": OTP,
    };
    if (isOtpEnterd)
      await notifer.verifyPhone(
        body: body,
        context: context,
        isFromSetting: true,
      );
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: w / 40),
      child: Container(
        width: w / 1.15,
        height: h / 2.15,
        padding: EdgeInsets.symmetric(vertical: h / 80, horizontal: w / 16),
        child: Column(
          children: [
            SizedBox(height: h / 60),
            MyTextPoppines(
              text: "Let's Verify your Mobile No",
              fontSize: w / 24,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: h / 70),
            Image.asset('assets/icons/email.png'),
            SizedBox(height: h / 40),
            MyTextPoppines(
              text: "We have sent you an OTP with your \n reiestered Mobile no",
              fontSize: w / 32,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withOpacity(0.6),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h / 60),
            Align(
              alignment: Alignment.centerLeft,
              child: MyTextPoppines(
                text: "Verify OTP",
                fontSize: w / 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h / 80),
            // OTP TEXT FIELD
            OTPTextField(
              length: 6,
              width: w,
              fieldWidth: w / 10,
              otpFieldStyle: OtpFieldStyle(
                focusBorderColor: AppColors.black,
              ),
              outlineBorderRadius: w / 40,
              fieldStyle: FieldStyle.box,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              keyboardType: TextInputType.number,
              contentPadding: EdgeInsets.symmetric(vertical: h / 140),
              style: TextStyle(
                fontSize: w / 28,
                fontWeight: FontWeight.bold,
              ),
              onCompleted: (value) {
                setState(() => isOtpEnterd = true);
                setState(() => otp = value);
                print("otp set" + otp);
                print("Completed " + value);
              },
            ),
            SizedBox(height: h / 40),
            MyBlueButton(
              isWaiting: authNotifier.loading,
              hPadding: w / 4,
              vPadding: h / 60,
              text: "Verify OTP",
              onTap: () => _verifyPhoneNoHandler(otp),
            )
          ],
        ),
      ),
    );
  }
}

class _VerifyEmailDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    final h = context.screenHeight;
    final w = context.screenWidth;

    // verify email handler
    Future _verifyEmailHandler() async {
      final notifer = context.read<AuthNotifier>();
      await notifer.verifyEmail(context);
    }

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: w / 40),
      child: Container(
        width: w / 1.15,
        height: h / 2.4,
        padding: EdgeInsets.symmetric(vertical: h / 80, horizontal: w / 16),
        child: Column(
          children: [
            SizedBox(height: h / 60),
            MyTextPoppines(
              text: "Let's Verify your Email",
              fontSize: w / 24,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: h / 70),
            Image.asset('assets/icons/email.png'),
            SizedBox(height: h / 40),
            MyTextPoppines(
              text: "We have sent you a link with your \n reiestered EMAIL",
              fontSize: w / 32,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withOpacity(0.6),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h / 80),
            MyBlueButton(
              isWaiting: authNotifier.loading,
              hPadding: w / 4,
              vPadding: h / 60,
              text: "Get verification Lonk ",
              onTap: () => _verifyEmailHandler(),
            )
          ],
        ),
      ),
    );
  }
}
