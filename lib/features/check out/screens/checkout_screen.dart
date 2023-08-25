// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/provider/notifiers/check_out_notifier.dart';
import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../estimate/widget/saved_adresses_widget.dart';
import '../widget/checkout_bottom_bar.dart';
import '../widget/checkout_summary_card_widget.dart';

class CheckOutScreen extends StatefulWidget {
  static const String routeName = '/checkout';
  const CheckOutScreen({
    Key? key,
    required this.ProjectName,
    required this.bookingId,
    required this.amountToPay,
  }) : super(key: key);
  final String ProjectName;
  final String bookingId;
  final String amountToPay;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final checkOutNotifier = context.watch<CheckOutNotifier>();
    return ModalProgressHUD(
      inAsyncCall: checkOutNotifier.loading,
      child: Scaffold(
        appBar: MyAppBar(text: "Checkout"),
        body: SizedBox(
          height: 550.h,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckOutSummaryCardWidget(totalAmount: widget.amountToPay),
                  8.vspacing(context),
                  const Divider(thickness: 1.0),
                  8.vspacing(context),
                  const SavedAddressesWidget(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CheckOutBottomBar(
          projectName: widget.ProjectName,
          totalAmount: widget.amountToPay,
          bookingId: widget.bookingId,
        ),
      ),
    );
  }
}
