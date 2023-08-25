// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../provider/notifiers/estimate_notifier.dart';

class EstimatedWorkBillCardWidget extends StatelessWidget {
  final int index;
  const EstimatedWorkBillCardWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getEstProvider = context.read<EstimateNotifier>();
    final projectDetails = getEstProvider.estimated.estimatedWorks![index];
    final coustmer = projectDetails.billTo!;
    final String? fullUserDetails =
        "${coustmer.name}, ${coustmer.address}, ${coustmer.country}.";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _EstimatedDetailsRow(
          prefixText: "Estimate Date :",
          suffixText: projectDetails.estimateDate.toString(),
        ),
        15.vs,
        _EstimatedDetailsRow(
          prefixText: "Deposited Amount :",
          suffixText: "\$${projectDetails.projectBilling!.depositAmount}",
        ),
        15.vs,
        _EstimatedDetailsRow(
          prefixText: "Bill To :",
          suffixText: fullUserDetails!,
        ),
        15.vs,
        _EstimatedDetailsRow(
          prefixText: "Email :",
          suffixText: coustmer.email.toString(),
        ),
        15.vs,
        _EstimatedDetailsRow(
          prefixText: "Contact No :",
          suffixText: "+1${coustmer.phone}",
        ),
      ],
    );
  }
}

class _EstimatedDetailsRow extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  const _EstimatedDetailsRow({
    Key? key,
    required this.prefixText,
    required this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.hs,
        MyTextPoppines(
          text: prefixText,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        10.hs,
        Expanded(
          child: MyTextPoppines(
            text: suffixText,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            maxLines: 10,
            height: 1.5,
          ),
        ),
        70.hs,
      ],
    );
  }
}
