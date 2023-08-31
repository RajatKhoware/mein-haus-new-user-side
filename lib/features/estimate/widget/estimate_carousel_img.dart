// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    final height = MediaQuery.sizeOf(context).height;
    final getEstProvider = context.read<EstimateNotifier>().estimated;
    final projectImgs =
        getEstProvider.estimatedWorks![widget.index].uploadedImgs;
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: height / 4.3,
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
        SizedBox(height: height / 60),
        //Dots indicator
        Visibility(
          visible: projectImgs.length > 1 && projectImgs.isNotEmpty,
          child: buildIndicator(projectImgs),
        ),
      ],
    );
  }

  //Carousle Container
  Widget buildImg(
    UploadedImgs workImg,
    int index,
    List<UploadedImgs> imgs,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushScreen(
          FullScreenImageView(
            images: imgs,
            currentIndex: index,
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: workImg.thumbnailUrl!,
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.symmetric(horizontal: width / 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 14),
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
  }

  //Dot indicator
  Widget buildIndicator(List<UploadedImgs> projectImgs) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: width / 6),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: projectImgs.length,
          effect: ScrollingDotsEffect(
            dotWidth: width / 70,
            dotHeight: width / 70,
            activeDotScale: 1.5,
            activeDotColor: AppColors.black,
            spacing: width / 60,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 30),
            color: AppColors.black.withOpacity(0.3),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: width / 26,
            vertical: height / 200,
          ),
          child: MyTextPoppines(
            text: "${activeIndex + 1}/${projectImgs.length}",
            fontSize: width / 38,
            color: AppColors.white,
            height: 1.6,
            fontWeight: FontWeight.w600,
          ),
        ),
        //SizedBox(width: width / 14),
      ],
    );
  }
}
