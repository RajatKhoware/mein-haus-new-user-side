import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/provider/notifiers/address_notifier.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/res/common/buttons/my_bottom_bar_button.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/show_picked_images.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../res/common/my_snake_bar.dart';
import '../../../utils/extensions/validator.dart';
import '../../../utils/utils.dart';
import '../../address/widget/address_list_tile.dart';
import '../../estimate/screens/estimate_generation_screen.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/user_details_toggle_button.dart';

class CreateStartingProject extends StatefulWidget {
  const CreateStartingProject({super.key});

  @override
  State<CreateStartingProject> createState() => _CreateStartingProjectState();
}

class _CreateStartingProjectState extends State<CreateStartingProject> {
  // Form key to validate all the textfeilds
  final _estimateFormKey = GlobalKey<FormState>();

  // All Controller to saved values form user input
  TextEditingController addressController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Focus node to shift the focus from one textfield to another
  FocusNode nameNode = FocusNode();
  FocusNode descNode = FocusNode();

  // Deafult selected address is null
  String selectedAddress = '';

  @override
  void initState() {
    super.initState();
    addressController.addListener(() {
      onChange();
    });
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }

  // Getting all the address suggestion according to address controller
  void onChange() {
    final notifier = context.read<AddressNotifier>();
    notifier.getAddressSuggestions(addressController.text);
  }

  // After verfication user can able to create its first project/estimate
  Future<void> createStartingProject() async {
    final notifier = context.read<EstimateNotifier>();
    final image = await Utils.collectImages(notifier.images);
    var addresses = await Utils.getCordinates(selectedAddress);
    var first = addresses.first;
    final data = {
      'title': titleController.text,
      'description': descriptionController.text,
      'time': selectedOption.toString(),
      'address': addressController.text,
      "longitude": first.longitude.toString(),
      "latitude": first.latitude.toString(),
      'images[]': image,
    };
    await notifier.createStartingEstimate(context: context, data: data);
  }

  @override
  Widget build(BuildContext context) {
    final addressNotifier = context.watch<AddressNotifier>();
    final estimateNotifer = context.watch<EstimateNotifier>();
    final authNotifer = context.watch<AuthNotifier>();
    // Mediaquerys for responsiveness
    final h = context.screenHeight;
    final w = context.screenWidth;
    return ModalProgressHUD(
      inAsyncCall: estimateNotifer.loading,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title -> Headline + Skip button
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 90),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextPoppines(
                          text: "Start you project",
                          fontSize: w / 24,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: h / 130),
                        MyTextPoppines(
                          text: "We will provide you an estimate right away",
                          fontSize: w / 34,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName,
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Skip",
                        style: GoogleFonts.poppins(
                          fontSize: w / 28,
                          color: AppColors.buttonBlue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w / 20),
                    child: Form(
                      key: _estimateFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title textfield
                          MyTextField(
                            text: "Title",
                            hintText: "Project title",
                            isHs20: false,
                            focusNode: nameNode,
                            controller: titleController,
                            onSubmit: (value) {
                              Utils.fieldFocusChange(
                                context,
                                nameNode,
                                descNode,
                              );
                            },
                            validator: Validator().nullValidator,
                          ),
                          SizedBox(height: h / 130),
                          // Description textfield
                          MyTextField(
                            text: "Description",
                            hintText: "Project description",
                            maxLines: 4,
                            isHs20: false,
                            controller: descriptionController,
                            focusNode: descNode,
                            validator: Validator().nullValidator,
                          ),
                          SizedBox(height: h / 130),
                          // [Dropdwon] When would you like to have this task to be done?
                          GenerateEstimateDropdown(),
                          SizedBox(height: h / 130),
                          // Address textfield with auto suggestion
                          MyTextField(
                            text: "Addresss",
                            hintText: "44 E. West Street Ashland, OH 44805.",
                            isHs20: false,
                            controller: addressController,
                            validator: Validator().nullValidator,
                          ),
                          SizedBox(height: h / 130),
                          addressNotifier.addressList.isEmpty
                              ? SizedBox()
                              : MyTextPoppines(
                                  text: "Suggestions",
                                  fontSize: w / 32,
                                  fontWeight: FontWeight.w600,
                                ),
                          SizedBox(height: h / 90),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: addressNotifier.addressList.length,
                            itemBuilder: (context, index) {
                              final address = addressNotifier.addressList[index]
                                  ["description"];
                              return ListAddressTile(
                                onTap: () {
                                  addressController.text = address;
                                  selectedAddress = address;
                                  addressNotifier.addressList.clear();
                                },
                                address: address,
                              );
                            },
                          ),
                          // Upload Images Section
                          SizedBox(height: h / 50),
                          MyTextPoppines(
                            text: "Upload clear photos of project area",
                            fontSize: w / 34,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: h / 80),
                          estimateNotifer.images.isEmpty
                              ? InkWell(
                                  onTap: () =>
                                      estimateNotifer.getImagess(context),
                                  child: Container(
                                    width: w / 6,
                                    height: h / 12.5,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(w / 30),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: w / 14,
                                    ),
                                  ),
                                )
                              : ShowPickedImages<EstimateNotifier>(),
                          SizedBox(height: h / 80),
                          MyTextPoppines(
                            text: "You can select multiple images",
                            fontSize: w / 36,
                            fontWeight: FontWeight.w500,
                            color: AppColors.golden,
                          ),
                          SizedBox(height: h / 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Terms and Condition Block
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: w / 50, vertical: h / 40),
                color: const Color(0xFFF0F8FF),
                child: Row(
                  children: [
                    SizedBox(width: w / 20),
                    SizedBox(
                      width: w / 1.5,
                      child: Text.rich(
                        TextSpan(
                          text:
                              'By Signing Up with MeinHaus you agree with our ',
                          style: TextStyle(fontSize: h / 55),
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w / 30,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                fontSize: w / 30,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w / 30,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: w / 20),
                    UserDeatilsToggleButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Submit button
        bottomNavigationBar: MyBottomNavWidget(
          hPadding: w / 4,
          text: "Submit",
          onTap: () {
            if (_estimateFormKey.currentState!.validate()) {
              authNotifer.isToggle
                  ? createStartingProject()
                  : showSnakeBarr(
                      context,
                      "Please Accept T&C",
                      SnackBarState.Warning,
                    );
              ;
              ;
            }
          },
        ),
      ),
    );
  }
}
