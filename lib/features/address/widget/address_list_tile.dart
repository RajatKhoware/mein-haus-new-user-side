// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/common/my_text.dart';



class ListAddressTile extends StatelessWidget {
  final VoidCallback onTap;
  final String address;
  const ListAddressTile({
    Key? key,
    required this.onTap,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          leading: Icon(
            Icons.share_location,
            size: 20.sp,
          ),
          title: MyTextPoppines(
            text: address,
            maxLines: 2,
          ),
        ),
        Divider(
          thickness: 2,
          height: 0,
          color: Color.fromARGB(20, 0, 0, 0),
        )
      ],
    );
  }
}
