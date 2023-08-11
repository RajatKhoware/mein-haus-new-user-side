// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/provider/notifiers/additional_work_notifier.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../res/common/my_text.dart';
import 'icon_button_with_text.dart';

class AdditionalWorkProProvideCardWidget extends StatefulWidget {
  final int index;
  const AdditionalWorkProProvideCardWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<AdditionalWorkProProvideCardWidget> createState() =>
      _AdditionalWorkProProvideCardWidgetState();
}

class _AdditionalWorkProProvideCardWidgetState
    extends State<AdditionalWorkProProvideCardWidget> {
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AdditionalWorkNotifier>();
    final work = notifier.additionalWork.additionalWork![widget.index];
    final bool isWaitingCard = work.status == 0 && work.amount != null;
    final bool isApprovedCard = work.status == 1;
    final bool isPending = work.status == 0 && work.amount == null;
    final isImgNull = work.images != null;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: boxShadow,
        color: AppColors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: MyTextPoppines(
              text: work.title ?? "",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          const Divider(thickness: 1.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Images
                isImgNull
                    ? SizedBox(
                        height: 100.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: work.images!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 110.w,
                              height: 100.h,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Image.network(
                                work.images![index].thumbnailUrl!,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    "assets/images/room/room_4.png",
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : Image.asset("assets/images/image_not_found.png"),
                const Divider(thickness: 1.0),
                5.vs,
                MyTextPoppines(
                  text: "Description",
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
                10.vs,
                MyTextPoppines(
                  text: work.description ?? "",
                  fontSize: 10.sp,
                  maxLines: 6,
                  height: 1.4,
                  color: AppColors.black.withOpacity(0.4),
                ),
                5.vs,
                const Divider(thickness: 1.0),
                10.vs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Price
                    Visibility(
                      visible: work.amount != null,
                      child: Row(
                        children: [
                          MyTextPoppines(
                            text: "Price :   ",
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                          MyTextPoppines(
                            text: "\$${work.amount}",
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.yellow,
                          ),
                        ],
                      ),
                    ),
                    isPending
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButtonWithText(
                                text: "Pending",
                                textColor: AppColors.white,
                                buttonColor: Color.fromARGB(255, 255, 217, 5),
                                onTap: () {},
                                isIcon: true,
                              ),
                            ],
                          )
                        : isWaitingCard
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButtonWithText(
                                    text: "Reject",
                                    textColor: AppColors.white,
                                    buttonColor: const Color(0xFFFF1414),
                                    onTap: () => _rejectAdditionalWorkHandler(),
                                    isIcon: true,
                                  ),
                                  10.hs,
                                  IconButtonWithText(
                                    text: "Aprrove",
                                    textColor: AppColors.white,
                                    buttonColor: const Color(0xFF68E365),
                                    onTap: () =>
                                        _approveAdditionalWorkHandler(),
                                    iconUrl: "assets/icons/approved_it.png",
                                    isIcon: false,
                                  ),
                                ],
                              )
                            : isApprovedCard
                                ? IconButtonWithText(
                                    text: "Approved",
                                    textColor: const Color(0xFF68E365),
                                    buttonColor: const Color(0xFF68E365)
                                        .withOpacity(0.12),
                                    onTap: () {},
                                    iconUrl: "assets/icons/approved.png",
                                    isIcon: false,
                                  )
                                : IconButtonWithText(
                                    text: "Rejected",
                                    textColor: const Color(0xFFFF1414),
                                    buttonColor: const Color(0xFFFF1414)
                                        .withOpacity(0.12),
                                    onTap: () {},
                                    isIcon: true,
                                  ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _approveAdditionalWorkHandler() async {
    final notifier = context.read<AdditionalWorkNotifier>();
    final work = notifier.additionalWork.additionalWork![widget.index];
    await notifier.approve(
      context: context,
      id: work.id.toString(),
    );
  }

  _rejectAdditionalWorkHandler() async {
    final notifier = context.read<AdditionalWorkNotifier>();
    final work = notifier.additionalWork.additionalWork![widget.index];
    await notifier.reject(
      context: context,
      id: work.id.toString(),
    );
  }
}
