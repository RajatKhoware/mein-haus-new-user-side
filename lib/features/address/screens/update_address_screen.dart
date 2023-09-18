// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/auth/screens/user_details.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../data/network/network_api_servcies.dart';
import '../../../provider/notifiers/address_notifier.dart';
import '../../../resources/common/my_snake_bar.dart';
import '../../../resources/common/my_text.dart';
import '../../../utils/utils.dart';
import '../widget/address_list_tile.dart';

class UpdateAdressScreen extends StatefulWidget {
  static const String routeName = '/update-address';
  const UpdateAdressScreen({
    Key? key,
    required this.perAddress,
    required this.addressId,
  }) : super(key: key);
  final String perAddress;
  final String addressId;

  @override
  State<UpdateAdressScreen> createState() => _UpdateAdressScreenState();
}

class _UpdateAdressScreenState extends State<UpdateAdressScreen> {
  TextEditingController addressController = TextEditingController();

  String selectedAddres = '';
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.perAddress);
    addressController.addListener(() => onChange());
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

  Future _updateAddressHandler() async {
    final notifier = context.read<AddressNotifier>();
    var addresses = await Utils.getCordinates(addressController.text);
    var first = addresses.first;
     var address2 = await Utils.getAddress(first.latitude, first.longitude);
    var first2 = address2.first; 
    final MapSS body = {
      "address_id": widget.addressId,
      "address": selectedAddres,
      "longitude": first.longitude.toString(),
      "latitude": first.latitude.toString(),
       'line1': first2.name.toString(),
        'line2': first2.street.toString(),
        'city': first2.locality.toString(),
        'state': first2.administrativeArea.toString(),
        'country': first2.country.toString(),
        'postal_code': first2.postalCode.toString(),
    };
    await notifier.updateAddress(context: context, body: body);
  }

  Future _deleteAddressHandler() async {
    final notifier = context.read<AddressNotifier>();
    final MapSS body = {"id": widget.addressId};
    await notifier.deleteAddress(context: context, body: body);
  }

  @override
  Widget build(BuildContext context) {
    final addressNotifier = context.watch<AddressNotifier>();
    return ModalProgressHUD(
      inAsyncCall: addressNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Edit Address"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTextField(
              text: "Edit Address",
              controller: addressController,
              hintText: "44 E. West Street Ashland, OH 44805.",
            ),
            Divider(thickness: 2, color: Color.fromARGB(32, 0, 0, 0)),
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
                      print("selectedAddres : $selectedAddres");
                    },
                    address: address,
                  );
                },
              ),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyBlueButton(
                hPadding: 60.w,
                text: "Delete",
                onTap: () => _deleteAddressHandler(),
              ),
              MyBlueButton(
                hPadding: 60.w,
                text: "Update",
                onTap: () {
                  selectedAddres.isNotEmpty
                      ? _updateAddressHandler()
                      : showSnakeBar(context, "Select an address please");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
