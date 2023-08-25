// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:new_user_side/provider/notifiers/customer_support_notifier.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_bottom_bar_button.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/my_snake_bar.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../utils/extensions/get_images.dart';
import '../../../utils/extensions/show_picked_images.dart';
import '../../../utils/utils.dart';
import '../../auth/screens/user_details.dart';

class SendQueryScreen extends StatefulWidget {
  static const String routeName = '/sendQuery';
  const SendQueryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SendQueryScreen> createState() => _SendQueryScreenState();
}

class _SendQueryScreenState extends State<SendQueryScreen> {
  final _queryFormKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getRasiedQuery();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future getImages() async {
    await GetImages().pickImages<CustomerSupportNotifier>(context: context);
  }

  Future sendQuery() async {
    final notifier = context.read<CustomerSupportNotifier>();
    final estimateNotifier = context.read<EstimateNotifier>();
    final project = estimateNotifier.projectDetails.services!;
    final image = await Utils.collectImages(notifier.images);
    Map<String, dynamic> body = {
      "estimate_service_id": project.projectId.toString(),
      "query_text": _controller.text,
      "query_files[]": image,
    };
    if (notifier.images.length > 0) {
      if (_queryFormKey.currentState!.validate()) {
        await notifier.sendQuery(context: context, body: body);
      }
    } else {
      showSnakeBarr(
        context,
        "Please selecte an image to make request",
        SnackBarState.Warning,
      );
    }
  }

  Future getRasiedQuery() async {
    final notifier = context.read<CustomerSupportNotifier>();
    final estimateNotifier = context.read<EstimateNotifier>();
    final project = estimateNotifier.projectDetails.services!;
    final projectId = project.projectId.toString();
    await notifier.getRaisedQuery(context: context, id: projectId);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<CustomerSupportNotifier>();
    final estimateNotifier = context.read<EstimateNotifier>();
    final project = estimateNotifier.projectDetails.services;
    final raisedQuery = notifier.queryModel.queries;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return project != null && raisedQuery != null
        ? ModalProgressHUD(
            inAsyncCall: notifier.loading,
            child: Scaffold(
              appBar: MyAppBar(text: "Customer Support"),
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: width / 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Name, Booking Id
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 20, vertical: height / 80),
                        color: AppColors.yellow.withOpacity(0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextPoppines(
                              text: project.projectName.toString(),
                              fontSize: width / 28,
                              fontWeight: FontWeight.w500,
                            ),
                            MyTextPoppines(
                              text: project.estimateNo.toString(),
                              fontSize: width / 35,
                              color: AppColors.yellow,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      1.5.vspacing(context),
                      const Divider(thickness: 1.0, height: 0.0),
                      4.vspacing(context),
                      Expanded(
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 26),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                  key: _queryFormKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: MyTextField(
                                    text: "Enter your query below..",
                                    maxLines: 6,
                                    hintText:
                                        "Hi Team What If I Want Another Pro..",
                                    controller: _controller,
                                    isHs20: false,
                                    headingFontWeight: FontWeight.w500,
                                    validator: Validator().nullValidator,
                                  ),
                                ),
                                2.vspacing(context),
                                // Select File button
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextPoppines(
                                        text: "Select Photos To Upload :",
                                        fontSize: width / 34,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      InkWell(
                                        onTap: () => getImages(),
                                        child: Container(
                                          width: width / 3.4,
                                          height: height / 26,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.textBlue1E9BD0,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyTextPoppines(
                                                text: "Select File",
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.buttonBlue,
                                                fontSize: width / 28,
                                              ),
                                              2.hspacing(context),
                                              Icon(
                                                Icons.attach_file,
                                                color: AppColors.buttonBlue,
                                                size: width / 28,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                4.vspacing(context),
                                Visibility(
                                  visible: notifier.images.isNotEmpty,
                                  child: ShowPickedImages<
                                      CustomerSupportNotifier>(),
                                ),
                                Divider(thickness: 1.0),

                                Visibility(
                                  visible: raisedQuery.length != 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      6.vspacing(context),
                                      MyTextPoppines(
                                        text: "Raised Query",
                                        fontSize: width / 30,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.grey,
                                      ),
                                      4.vspacing(context),
                                      QueryDisplayBox(),
                                      6.vspacing(context),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: MyTextPoppines(
                                          text:
                                              "[You have raised ${raisedQuery!.length} queries for this Job]",
                                          fontSize: width / 40,
                                          color: AppColors.yellow,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: MyBottomNavWidget(
                hPadding: width / 3,
                text: "Send",
                onTap: () => sendQuery(),
              ),
            ),
          )
        : ModalProgressHUD(inAsyncCall: true, child: Scaffold());
  }
}

class QueryDisplayBox extends StatefulWidget {
  const QueryDisplayBox({super.key});

  @override
  State<QueryDisplayBox> createState() => _QueryDisplayBoxState();
}

int currentIndex = 0;

class _QueryDisplayBoxState extends State<QueryDisplayBox> {
  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    final height = context.screenHeight;
    final notifier = context.watch<CustomerSupportNotifier>();
    final raisedQuery = notifier.queryModel.queries;
    final isQueryRaised = raisedQuery?.length != 0;

    return isQueryRaised
        ? Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.black.withOpacity(0.04),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width / 30, vertical: height / 85),
                child: Column(
                  children: [
                    // Pev Query
                    Container(
                      color: AppColors.black.withOpacity(0.04),
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 50, vertical: height / 85),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextPoppines(
                                text: "•",
                                fontSize: width / 38,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black.withOpacity(0.6),
                              ),
                              2.hspacing(context),
                              SizedBox(
                                width: width / 1.4,
                                child: MyTextPoppines(
                                  text: raisedQuery![currentIndex]
                                      .query
                                      .toString(),
                                  fontSize: width / 38,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black.withOpacity(0.6),
                                  maxLines: 100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    4.vspacing(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (currentIndex > 0) --currentIndex;
                            });
                          },
                          child: Container(
                            width: width / 18,
                            height: height / 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.buttonBlue,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.buttonBlue,
                                size: width / 40,
                              ),
                            ),
                          ),
                        ),
                        10.hspacing(context),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (currentIndex < (raisedQuery.length - 1))
                                currentIndex++;
                            });
                          },
                          child: Container(
                            width: width / 18,
                            height: height / 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.buttonBlue,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.buttonBlue,
                                size: width / 40,
                              ),
                            ),
                          ),
                        ),
                        65.hspacing(context),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.golden,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: width / 50, vertical: height / 230),
                          child: Center(
                            child: MyTextPoppines(
                              text: "${currentIndex + 1}/${raisedQuery.length}",
                              color: AppColors.white,
                              fontSize: width / 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        : SizedBox();
  }
}
