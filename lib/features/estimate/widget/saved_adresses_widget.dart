// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_side/features/address/screens/add_adress_screen.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/address_notifier.dart';
import '../../../resources/common/my_text.dart';
import '../../../provider/notifiers/auth_notifier.dart';
import 'address_card.dart';

class SavedAddressesWidget extends StatelessWidget {
  const SavedAddressesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<AuthNotifier>();
    final address = userProvider.user.savedAddress;

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                print(userProvider.user.savedAddress!.length);
              },
              child: MyTextPoppines(
                text: "Saved Address",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            Visibility(
              visible: (address != null && address.isNotEmpty),
              child: _AddAdressButton(),
            )
          ],
        ),
        20.vs,
        // Address
        Visibility(
          visible: address != null && address.isNotEmpty,
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: userProvider.user.savedAddress!.length,
              itemBuilder: (context, index) {
                final addressId = address![index].id;
                return Consumer<AddressNotifier>(
                  builder: (context, selectedAddress, child) {
                    return InkWell(
                      onTap: () {
                        selectedAddress.setSelectedAddress(index);
                        print(addressId);
                      },
                      child: AddressCardWidget(
                        index: index,
                        isSelected: selectedAddress.index == index,
                        addressId: addressId!,
                      ),
                    );
                  },
                );
              }),
        ),
        Visibility(
          visible: address == null && address!.isEmpty,
          child: NoAddressFoundWidget(),
        ),

        30.vs,
      ],
    );
  }
}

class NoAddressFoundWidget extends StatelessWidget {
  const NoAddressFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(width / 26),
        border: Border.all(
          color: AppColors.golden,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: height / 40),
          SvgPicture.asset("assets/svgs/no_saved_address.svg"),
          SizedBox(height: height / 50),
          MyTextPoppines(
            text: "No Saved Address found!",
            fontSize: width / 28,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height / 90),
          _AddAdressButton(),
          SizedBox(height: height / 60),
        ],
      ),
    );
  }
}

class _AddAdressButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width / 3.2,
      height: height / 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 20),
        border: Border.all(color: AppColors.buttonBlue),
      ),
      child: InkWell(
        onTap: () => context.pushNamedRoute(AddAddressScreen.routeName),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width / 100),
              child: MyTextPoppines(
                text: "Add Address",
                fontWeight: FontWeight.w600,
                fontSize: width / 32,
                color: AppColors.buttonBlue,
              ),
            ),
            Icon(
              Icons.add_circle_outline_sharp,
              size: width / 22,
              color: AppColors.buttonBlue,
            ),
          ],
        ),
      ),
    );
  }
}
