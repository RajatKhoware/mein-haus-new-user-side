import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../resources/common/cached_network_img_error_widget.dart';
import '../../../utils/extensions/full_screen_image_view.dart';

class OngoingProjectPhotoCardWidget extends StatelessWidget {
  const OngoingProjectPhotoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.watch<EstimateNotifier>();
    final services = notifier.projectDetails.services!;
    final EdgeInsets paddingH15 = EdgeInsets.symmetric(horizontal: width / 26);

    return Padding(
      padding: paddingH15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: "Project Photos :",
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
          20.vs,
          Container(
            padding: paddingH15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.white,
              boxShadow: boxShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.vs,
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: services.projectImages!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final images = services.projectImages!;
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushScreen(
                              FullScreenImageView(
                                images: images,
                                currentIndex: index,
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width / 40),
                            child: CachedNetworkImage(
                              imageUrl: images[index].thumbnailUrl!,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  CachedNetworkImgErrorWidget(),
                            ),
                          ),
                        ),
                      );
                    }),
                6.vspacing(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
