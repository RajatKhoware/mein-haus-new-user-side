import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/add%20card/screens/add_new_card_screen.dart';
import 'package:new_user_side/features/check%20out/widget/single_credit_card_widget.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../resources/common/my_text.dart';
import '../../../provider/notifiers/check_out_notifier.dart';

class SelectCeditCardWidget extends StatelessWidget {
  const SelectCeditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextPoppines(
          text: "Payment Method",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        15.vs,
        MyTextPoppines(
          text: "Add & manage your payment methods using secure payment system",
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        20.vs,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(20, 0, 0, 0),
                offset: const Offset(0, 0),
                blurRadius: 10.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: MyTextPoppines(
                  text: "Previously You have selected this card .",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.vs,
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Consumer<CheckOutNotifier>(
                      builder: (context, value, child) {
                        return InkWell(
                          onTap: () {
                            value.selectCard(index);
                          },
                          child: SingleCreditCardWidget(
                            isSelected: value.index == index,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const Divider(thickness: 1.0),
              8.vs,
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => context.pushNamedRoute(AddNewCard.routeName),
                  child: SizedBox(
                    width: 120.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.add_circle_outline_sharp,
                          size: height > 800 ? 16.sp : 18.sp,
                          color: AppColors.buttonBlue,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: MyTextPoppines(
                            text: "Add New Card",
                            fontWeight: FontWeight.w600,
                            fontSize: height > 800 ? 10.sp : 12.sp,
                            color: AppColors.buttonBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
