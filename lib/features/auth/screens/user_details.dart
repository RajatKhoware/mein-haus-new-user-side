import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:provider/provider.dart';

import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/local%20db/user_prefrences.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/utils.dart';

import '../../../provider/notifiers/address_notifier.dart';
import '../../../resources/common/my_snake_bar.dart';
import '../../address/widget/address_list_tile.dart';
import '../widgets/user_details_toggle_button.dart';

class UserDetailsScreen extends StatefulWidget {
  static const String routeName = '/user-details';
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _userFormKey = GlobalKey<FormState>();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _contactNoController = TextEditingController();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode contactFocus = FocusNode();
  FocusNode addressFocus = FocusNode();

  String selectedAddres = '';
  String lat = "";
  String long = "";

  @override
  void initState() {
    super.initState();
    _addressController.addListener(() {
      onChange();
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNoController.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    contactFocus.dispose();
    addressFocus.dispose();
    super.dispose();
  }

  void onChange() {
    final notifier = context.read<AddressNotifier>();
    notifier.getAddressSuggestions(_addressController.text);
  }

  _signUpHandler() async {
    final notifier = context.read<AuthNotifier>();
    final String userId = await UserPrefrences().getUserId();
    final address = await Utils.getCordinates(_addressController.toString());
    long = address.first.longitude.toString();
    lat = address.first.latitude.toString();
    MapSS data = {
      "firstname": _firstNameController.text,
      "lastname": _lastNameController.text,
      "phone": _contactNoController.text,
      "address": _addressController.text,
      "user_id": userId,
      "longitude": long,
      "latitude": lat,
    };
  //  await notifier.submitUserDetails(context: context, body: data);
  }

  @override
  Widget build(BuildContext context) {
    final addressNotifier = context.watch<AddressNotifier>();
    final height = MediaQuery.of(context).size.height;
    final fontsize = height / 55;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MyAppBar(text: "General Details", isLogoVis: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _userFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      text: "Enter your first name",
                      controller: _firstNameController,
                      focusNode: firstNameFocus,
                      onSubmit: (p0) {
                        Utils.fieldFocusChange(
                            context, firstNameFocus, lastNameFocus);
                      },
                      validator: Validator().nullValidator,
                    ),
                    MyTextField(
                      text: "Enter your last name",
                      controller: _lastNameController,
                      focusNode: lastNameFocus,
                      onSubmit: (p0) {
                        Utils.fieldFocusChange(
                            context, lastNameFocus, contactFocus);
                      },
                      validator: Validator().nullValidator,
                    ),
                    MyTextField(
                      text: "Enter your contact no",
                      controller: _contactNoController,
                      focusNode: contactFocus,
                      onSubmit: (p0) {
                        Utils.fieldFocusChange(
                            context, contactFocus, addressFocus);
                      },
                      validator: Validator().nullValidator,
                    ),
                    MyTextField(
                      text: "Enter your Address",
                      controller: _addressController,
                      focusNode: addressFocus,
                      validator: Validator().nullValidator,
                    ),
                    15.vs,
                    addressNotifier.addressList.isEmpty
                        ? MyTextPoppines(
                            text: "       No Results",
                            fontWeight: FontWeight.w600,
                          )
                        : MyTextPoppines(
                            text: "       Suggestions",
                            fontWeight: FontWeight.w600,
                          ),
                    10.vs,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: addressNotifier.addressList.length,
                      itemBuilder: (context, index) {
                        final address =
                            addressNotifier.addressList[index]["description"];
                        return ListAddressTile(
                          onTap: () async {
                            _addressController.text = address;
                            selectedAddres = address;
                            final query = _addressController.toString();
                            var addresses = await Utils.getCordinates(query);
                            var first = addresses.first;
                            setState(() {
                              lat = first.latitude.toString();
                              long = first.longitude.toString();
                            });
                            print("${long} : ${lat}");
                          },
                          address: address,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          10.vs,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            color: const Color(0xFFF0F8FF),
            child: Row(
              children: [
                20.hs,
                SizedBox(
                  width: 250.w,
                  child: Text.rich(
                    TextSpan(
                      text: 'By Signing Up with MeinHause you agree with our ',
                      style: TextStyle(fontSize: height / 55),
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontsize,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            fontSize: fontsize,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontsize,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
                25.hs,
                UserDeatilsToggleButton()
              ],
            ),
          ),
          5.vs,
          Divider(thickness: 2.h, indent: 10.w, endIndent: 10.w),
          20.vs,
          Consumer<AuthNotifier>(
            builder: (context, value, child) {
              return MyBlueButton(
                isWaiting: value.loading,
                hPadding: context.screenHeight / 7.81,
                text: "Submit & Sign Up",
                fontSize: height / 50,
                onTap: () async {
                  value.isToggle
                      ? _signUpHandler()
                      : showSnakeBar(context, "Please accept t&c..");
                },
              );
            },
          ),
          20.vs,
        ],
      ),
    );
  }
}

class MyTextField extends StatefulWidget {
  final String text;
  final bool? isSuffix;
  final int? maxLines;
  final double? width;
  final String? hintText;
  final bool? isHs20;
  final FontWeight? headingFontWeight;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;

  const MyTextField({
    Key? key,
    required this.text,
    this.isSuffix = false,
    this.maxLines = 1,
    this.width,
    this.hintText = '',
    this.isHs20 = true,
    this.headingFontWeight,
    this.controller,
    this.validator,
    this.focusNode,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.isHs20! ? 25.w : 0.w,
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: " ${widget.text}",
            fontWeight: widget.headingFontWeight ?? FontWeight.w600,
            fontSize: width / 28,
            maxLines: 1,
          ),
          3.vspacing(context),
          Container(
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextFormField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: widget.controller,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(194, 240, 240, 240),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width / 26,
                  vertical: widget.isSuffix!
                      ? 14.h
                      : widget.maxLines == 1
                          ? 0
                          : height / 80,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.blue.shade400,
                    width: 1.5.w,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Colors.red.shade300,
                    width: 1.5.w,
                  ),
                ),
                suffixIcon: widget.isSuffix!
                    ? InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.date_range_outlined,
                          color: AppColors.black,
                          size: 25.sp,
                        ),
                      )
                    : null,
                hintText: widget.hintText,
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.black.withOpacity(0.5),
                  fontSize: width / 36,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: width / 36,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              validator: widget.validator,
              focusNode: widget.focusNode,
              onFieldSubmitted: widget.onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
