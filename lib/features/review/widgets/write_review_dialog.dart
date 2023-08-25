// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/validator.dart';
import 'package:provider/provider.dart';

import '../../../data/network/network_api_servcies.dart';

class WriteReviewDialog extends StatefulWidget {
  @override
  State<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  final _reviewKey = GlobalKey<FormState>();
  TextEditingController _reviewController = TextEditingController();
  int punctuality = 4;
  int responsiveness = 4;
  int quality = 4;

  Future _reviewHandler() async {
    final notifier = context.read<EstimateNotifier>();
    final estimateId = notifier.projectDetails.services!.projectId.toString();
    MapSS body = {
      "estimate_service_id": estimateId,
      "responsiveness": responsiveness.toString(),
      "quality": quality.toString(),
      "punctuality": punctuality.toString(),
      "review": _reviewController.text,
    };
    if (_reviewKey.currentState!.validate()) {
      await notifier.writeReview(context: context, body: body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: width / 20),
        child: Container(
          height: height / 1.7,
          child: GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.vspacing(context),
                  MyTextPoppines(
                    text:
                        "Please write Overall level of satisfaction with your Project/Pro Service.",
                    fontSize: width / 28,
                    fontWeight: FontWeight.w600,
                  ),
                  8.vspacing(context),
                  _buildRatingBar(
                    ratingVal: punctuality,
                    title: "Punctuality :",
                    onRatingUpdate: (rating) {
                      setState(() {
                        punctuality = rating.toInt();
                      });
                    },
                  ),
                  3.vspacing(context),
                  _buildRatingBar(
                    ratingVal: responsiveness,
                    title: "Responsiveness :",
                    onRatingUpdate: (rating) {
                      setState(() {
                        responsiveness = rating.toInt();
                      });
                    },
                  ),
                  3.vspacing(context),
                  _buildRatingBar(
                    ratingVal: quality,
                    title: "Quality :",
                    onRatingUpdate: (rating) {
                      setState(() {
                        quality = rating.toInt();
                      });
                    },
                  ),
                  4.vspacing(context),
                  Divider(thickness: 1.0),
                  Form(
                    key: _reviewKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: MyTextField(
                      text: "Review",
                      isHs20: false,
                      hintText: "Write you review here",
                      maxLines: height > 750 ? 6 : 3,
                      headingFontWeight: FontWeight.w500,
                      controller: _reviewController,
                      validator: Validator().nullValidator,
                    ),
                  ),
                  4.vspacing(context),
                  Center(
                    child: MyBlueButton(
                      isWaiting: notifier.reviewLoading,
                      hPadding: width / 4,
                      vPadding: height / 55,
                      fontSize: width / 26,
                      text: "Submit",
                      onTap: () => _reviewHandler(),
                    ),
                  ),
                  2.vspacing(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _buildRatingBar extends StatefulWidget {
  int ratingVal;
  final String title;
  final Function(double) onRatingUpdate;
  _buildRatingBar({
    Key? key,
    required this.ratingVal,
    required this.title,
    required this.onRatingUpdate,
  }) : super(key: key);

  @override
  State<_buildRatingBar> createState() => __buildRatingSnackBarState();
}

class __buildRatingSnackBarState extends State<_buildRatingBar> {
  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextPoppines(
          text: widget.title,
          fontSize: width / 28,
          fontWeight: FontWeight.w500,
        ),
        RatingBar.builder(
          initialRating: widget.ratingVal.toDouble(),
          minRating: 1,
          itemSize: width / 13,
          direction: Axis.horizontal,
          updateOnDrag: true,
          // unratedColor: AppColors.white,
          glowColor: AppColors.golden,
          itemBuilder: (context, _) => Icon(
            Icons.star_rounded,
            color: Colors.yellow.shade700,
          ),
          onRatingUpdate: widget.onRatingUpdate,
        ),
      ],
    );
  }
}
