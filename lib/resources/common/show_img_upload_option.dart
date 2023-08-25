// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/provider/notifiers/upload_image_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/show_picked_images.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/extensions/get_images.dart';
import '../../utils/utils.dart';

class ShowImgUploadOption extends StatelessWidget {
  final String bookingId;
  const ShowImgUploadOption({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.watch<UploadImgNotifier>();
    bool isImgPresent = notifier.images.length > 0;
    GetImages getImages = GetImages();

    Future getImagess() async {
      await getImages.pickImages<UploadImgNotifier>(context: context);
    }

    Future uploadImages() async {
      final notifier = context.read<UploadImgNotifier>();
      final image = await Utils.collectImages(notifier.images);
      ResponseType body = {"booking_id": bookingId, "imgs[]": image};
      await notifier.uploadImg(context: context, body: body);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 16),
      child: Column(
        children: [
          isImgPresent
              ? ShowPickedImages<UploadImgNotifier>()
              : DottedBorder(
                  dashPattern: const [4, 8],
                  strokeCap: StrokeCap.round,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(6),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 50, vertical: height / 30),
                  color: AppColors.textBlue,
                  child: InkWell(
                    onTap: () => getImagess(),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            size: width / 12,
                            color: AppColors.textBlue,
                          ),
                          2.vspacing(context),
                          MyTextPoppines(
                            text: "Upload Images",
                            fontSize: width / 32,
                            color: AppColors.textBlue,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
          5.vspacing(context),
          Visibility(
            visible: isImgPresent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => notifier.setImagesInList([]),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: width / 30,
                      vertical: height / 200,
                    ),
                    child: MyTextPoppines(
                      text: "Cancel",
                      fontSize: width / 30,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                10.hspacing(context),
                InkWell(
                  onTap: () => uploadImages(),
                  child: Container(
                    width: width / 5.4,
                    height: height / 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.buttonBlue,
                    ),
                    child: notifier.loading
                        ? LoadingAnimationWidget.inkDrop(
                            color: Colors.white,
                            size: width / 30,
                          )
                        : Center(
                            child: MyTextPoppines(
                              text: "Upload",
                              fontSize: width / 30,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
