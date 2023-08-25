import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../../../resources/common/my_text.dart';

class SingleCreditCardWidget extends StatelessWidget {
  final bool isSelected;
  const SingleCreditCardWidget({
    Key? key,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isSelected ? const Divider(thickness: 1.0) : const SizedBox(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: isSelected
                ? AppColors.yellow.withOpacity(0.12)
                : Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSelected
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.r),
                        color: AppColors.grey.withOpacity(0.4),
                      ),
                      child: MyTextPoppines(
                        text: "Default",
                        height: 1.4,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox(),
              isSelected ? 5.vs : 0.vs,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 51.w,
                        height: 31.h,
                        child: Image.asset(
                          "assets/images/card.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      10.hs,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextPoppines(
                            text: "6546 XXXX XXXX 1233",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          8.vs,
                          Row(
                            children: [
                              MyTextPoppines(
                                text: "Expires On :",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              MyTextPoppines(
                                text: "5/25",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black.withOpacity(0.6),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(FontAwesomeIcons.ellipsis, size: 18.sp),
                ],
              ),
            ],
          ),
        ),
        isSelected ? const Divider(thickness: 1.0) : const SizedBox(),
      ],
    );
  }
}
