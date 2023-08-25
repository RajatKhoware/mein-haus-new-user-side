// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:new_user_side/features/address/screens/update_address_screen.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/my_text.dart';
import '../../../provider/notifiers/auth_notifier.dart';

class AddressCardWidget extends StatefulWidget {
  final int index;
  final bool isSelected;
  final int addressId;
  const AddressCardWidget({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.addressId,
  }) : super(key: key);

  @override
  State<AddressCardWidget> createState() => _AddressCardWidgetState();
}

class _AddressCardWidgetState extends State<AddressCardWidget> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthNotifier>(context, listen: true);
    final userAddress = userProvider.user.savedAddress![widget.index];
    final String fullAddres = userAddress.line1!.length == 1
        ? "${userAddress.line2}, ${userAddress.city}, ${userAddress.state}, ${userAddress.country}"
        : "${userAddress.line1}, ${userAddress.line2}, ${userAddress.city}, ${userAddress.state}, ${userAddress.country}";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: widget.isSelected
              ? AppColors.yellow
              : AppColors.black.withOpacity(0.2),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextPoppines(
                text: "Address ${widget.index + 1}",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UpdateAdressScreen(
                          perAddress: fullAddres,
                          addressId: widget.addressId.toString(),
                        );
                      },
                    ),
                  );
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AddAdressDialog();
                  //   },
                  // );
                },
                child: Icon(
                  FontAwesomeIcons.solidPenToSquare,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          10.vs,
          MyTextPoppines(
            text: fullAddres,
            maxLines: 3,
            fontSize: 14.sp,
            height: 1.3,
          ),
          10.vs,
          widget.isSelected
              ? Container(
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.yellow.withOpacity(0.08),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, top: 3.h),
                        child: MyTextPoppines(
                          text: "Selected",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.yellow,
                        ),
                      ),
                      Icon(
                        Icons.check_circle_outline_sharp,
                        size: 16.sp,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
