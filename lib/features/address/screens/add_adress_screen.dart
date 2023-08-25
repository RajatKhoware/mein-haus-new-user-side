// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/provider/notifiers/address_notifier.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../resources/common/my_snake_bar.dart';
import '../../../resources/common/my_text.dart';
import '../../../utils/utils.dart';
import '../widget/address_list_tile.dart';

class AddAddressScreen extends StatefulWidget {
  static const String routeName = '/add-address';
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController addressController = TextEditingController();
  String selectedAddres = '';

  @override
  void initState() {
    super.initState();
    addressController.addListener(() {
      onChange();
    });
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }

  void onChange() {
    final notifier = context.read<AddressNotifier>();
    notifier.getAddressSuggestions(addressController.text);
  }

  _addAddressHandler() async {
    final notifier = context.read<AddressNotifier>();
    var addresses = await Utils.getCordinates(selectedAddres);
    var first = addresses.first;
    final MapSS body = {
      "address": addressController.text,
      "longitude": first.longitude.toString(),
      "latitude": first.latitude.toString(),
    };
    await notifier.addAddress(context: context, body: body);
  }

  @override
  Widget build(BuildContext context) {
    final addressNotifier = context.watch<AddressNotifier>();
    return ModalProgressHUD(
      inAsyncCall: addressNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Add Address"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              text: "Add Address",
              controller: addressController,
              hintText: "44 E. West Street Ashland, OH 44805.",
            ),
            Divider(
              thickness: 2,
              color: Color.fromARGB(32, 0, 0, 0),
            ),
            10.vs,
            addressNotifier.addressList.isEmpty
                ? MyTextPoppines(
                    text: "       No Results",
                    fontWeight: FontWeight.w600,
                  )
                : MyTextPoppines(
                    text: "       Suggestions",
                    fontWeight: FontWeight.w600,
                  ),
            10.vs,
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: addressNotifier.addressList.length,
                itemBuilder: (context, index) {
                  final address =
                      addressNotifier.addressList[index]["description"];
                  return ListAddressTile(
                    onTap: () {
                      addressController.text = address;
                      selectedAddres = address;
                    },
                    address: address,
                  );
                },
              ),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(left: 40.w, bottom: 10.h),
          child: MyBlueButton(
            hPadding: 110.w,
            text: "Add Address",
            onTap: () {
              selectedAddres.isNotEmpty
                  ? _addAddressHandler()
                  : showSnakeBar(context, "Please Select an Address First");
            },
          ),
        ),
      ),
    );
  }
}
