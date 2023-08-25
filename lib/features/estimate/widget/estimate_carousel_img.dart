// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/data/models/generated_estimate_model.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../utils/extensions/full_screen_image_view.dart';

class EstimateCarouselImg extends StatefulWidget {
  final int index;
  const EstimateCarouselImg({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<EstimateCarouselImg> createState() => _EstimateCarouselImgState();
}

class _EstimateCarouselImgState extends State<EstimateCarouselImg> {
  // Active index of dots
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final getEstProvider = context.read<EstimateNotifier>();
    final projectImgs =
        getEstProvider.estimated.estimatedWorks![widget.index].uploadedImgs;
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 180.h,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            // autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            //reverse: true,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
          itemCount: projectImgs!.length,
          itemBuilder: (context, index, realIndex) {
            final workImg = projectImgs[index];
            return buildImg(workImg, index, projectImgs);
          },
        ),
        15.vs,
        //Dots indicator
        buildIndicator(projectImgs),
      ],
    );
  }

  //Carousle Container
  Widget buildImg(UploadedImgs workImg, int index, List<UploadedImgs> imgs) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FullScreenImageView(images: imgs, currentIndex: index),
            ),
          );
        },
        child: CachedNetworkImage(
          imageUrl: workImg.thumbnailUrl!,
          imageBuilder: (context, imageProvider) => Container(
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );

  //Dot indicator
  Widget buildIndicator(List<UploadedImgs> projectImgs) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: projectImgs.length,
            effect: ScrollingDotsEffect(
              dotWidth: 6.w,
              dotHeight: 6.h,
              activeDotScale: 1.5,
              activeDotColor: AppColors.black,
              spacing: 6.w,
            ),
          ),
          90.hs,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.black.withOpacity(0.3),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.h),
            child: MyTextPoppines(
              text: "$activeIndex/${projectImgs.length}",
              fontSize: 10.sp,
              color: AppColors.white,
              height: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
          30.hs,
        ],
      );
}
