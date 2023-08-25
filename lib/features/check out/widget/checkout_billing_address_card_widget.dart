import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/provider/notifiers/address_notifier.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../resources/common/my_text.dart';
import '../../estimate/widget/address_card.dart';

class CheckOutBillingAddressCardWidget extends StatelessWidget {
  const CheckOutBillingAddressCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextPoppines(
          text: "Billing Address",
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
        10.vs,
        // Address
        SizedBox(
          width: double.infinity,
          height: 250.h,
          child: ListView.builder(
              itemCount: 4,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Consumer<AddressNotifier>(
                  builder: (context, selectedAddress, child) {
                    return InkWell(
                      onTap: () => selectedAddress.setSelectedAddress(index),
                      child: AddressCardWidget(
                        index: index,
                        isSelected: selectedAddress.index == index,
                        addressId: 61,
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
