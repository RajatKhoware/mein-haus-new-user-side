import 'package:flutter/material.dart';
import 'package:new_user_side/features/review/widgets/write_review_dialog.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../resources/common/buttons/my_buttons.dart';

// ShowNoReview(),
class ShowReviewCard extends StatelessWidget {
  const ShowReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.watch<EstimateNotifier>();
    final review = notifier.projectDetails.services!.reviews!;

    return review.isEmpty
        ? ShowNoReview()
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
              boxShadow: boxShadow,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width / 25,
              vertical: height / 70,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width / 30,
              vertical: height / 70,
            ),
            child: Column(
              children: [
                2.vspacing(context),
                MyTextPoppines(
                  text: "Overall Ratings by You",
                  fontSize: width / 24,
                  fontWeight: FontWeight.w500,
                ),
                6.vspacing(context),
                // Rating bar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                    boxShadow: boxShadow,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width / 30),
                  child: Row(
                    children: [
                      _buildRatingBar(width: width, rating: 5),
                      8.hspacing(context),
                      Container(
                        height: height / 16,
                        width: 1,
                        color: AppColors.black,
                      ),
                      12.hspacing(context),
                      MyTextPoppines(
                        text: "4",
                        fontSize: width / 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.golden,
                      ),
                      4.hspacing(context),
                      MyTextPoppines(
                        text: "out of 5",
                        fontSize: width / 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                      ),
                    ],
                  ),
                ),
                8.vspacing(context),
                MyTextPoppines(
                  text: review[0].review.toString(),
                  fontSize: width / 28,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                  maxLines: 5,
                ),
                6.vspacing(context),
                _buildRatingTypes(
                  context: context,
                  title: "Punctualty :",
                  rating: double.parse(review.first.punctuality!.toString()),
                ),
                _buildRatingTypes(
                  context: context,
                  title: "Responsivness :",
                  rating: double.parse(review.first.responsiveness!.toString()),
                ),
                _buildRatingTypes(
                  context: context,
                  title: "Quality :",
                  rating: double.parse(review.first.quality!.toString()),
                ),
                2.vspacing(context),
              ],
            ),
          );
  }

  Widget _buildRatingTypes({
    required BuildContext context,
    required String title,
    required double rating,
  }) {
    final width = context.screenWidth;
    final height = context.screenHeight;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width / 25,
        vertical: height / 200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyTextPoppines(
            text: title,
            fontSize: width / 28,
            fontWeight: FontWeight.w500,
          ),
          _buildRatingBar(width: width, rating: rating),
        ],
      ),
    );
  }

  Widget _buildRatingBar({
    required double width,
    required double rating,
  }) {
    final starIcon = Icon(
      Icons.star_rounded,
      color: AppColors.golden,
      size: width / 12,
    );
    final halfStar = Icon(
      Icons.star_half_rounded,
      color: AppColors.golden,
      size: width / 12,
    );
    final emptyStar = Icon(
      Icons.star_rounded,
      color: AppColors.grey.withOpacity(0.4),
      size: width / 12,
    );

    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    List<Widget> starWidgets = [];

    for (int i = 0; i < fullStars; i++) {
      starWidgets.add(starIcon);
    }

    if (hasHalfStar) {
      starWidgets.add(halfStar);
    }

    int remainingStars = 5 - starWidgets.length;
    for (int i = 0; i < remainingStars; i++) {
      starWidgets.add(emptyStar);
    }

    return Row(children: starWidgets);
  }
}

class ShowNoReview extends StatelessWidget {
  const ShowNoReview({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.black.withOpacity(0.08),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width / 30,
              vertical: height / 80,
            ),
            child: MyTextPoppines(
              text: "No review yet, Add a review.",
              fontSize: width / 30,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
          MyBlueButton(
            hPadding: width / 30,
            text: "Write a review",
            vPadding: height / 80,
            fontWeight: FontWeight.w600,
            fontSize: width / 30,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return WriteReviewDialog();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
