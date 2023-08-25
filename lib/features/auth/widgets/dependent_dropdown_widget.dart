// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../utils/constants/app_list.dart';

class DependentDropDownForStateAndCities extends StatefulWidget {
  const DependentDropDownForStateAndCities({super.key});

  @override
  State<DependentDropDownForStateAndCities> createState() =>
      _DependentDropDownForStateAndCitiesState();
}

class _DependentDropDownForStateAndCitiesState
    extends State<DependentDropDownForStateAndCities> {
  String? selectedState;
  String? selectedCity;
  List<String> cities = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyTextPoppines(
                text: " Select State",
                fontWeight: FontWeight.w600,
              ),
              10.vs,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.whiteF9F9F9,
                ),
                child: DropdownButton<String>(
                  value: selectedState,
                  underline: const SizedBox(),
                  isExpanded: true,
                  icon: const Icon(CupertinoIcons.chevron_down),
                  iconSize: 20.sp,
                  borderRadius: BorderRadius.circular(20.r),
                  hint: MyTextPoppines(
                    text: "select state",
                    fontSize: 15.sp,
                    color: AppColors.black.withOpacity(0.7),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  dropdownColor: AppColors.whiteF9F9F9,
                  //List of items present in list
                  items: statesCities.keys.map((state) {
                    return DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedState = value;
                      cities = []; // clear the list of cities
                      if (statesCities.containsKey(value)) {
                        cities = statesCities[value]!;
                      }
                      selectedCity = null; // reset the selected city
                    });
                  },
                ),
              ),
            ],
          ),
          20.vs,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyTextPoppines(
                text: " Select City",
                fontWeight: FontWeight.w600,
              ),
              10.vs,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.whiteF9F9F9,
                ),
                child: DropdownButton<String>(
                  value: selectedCity,
                  underline: const SizedBox(),
                  isExpanded: true,
                  icon: const Icon(CupertinoIcons.chevron_down),
                  iconSize: 20.sp,
                  borderRadius: BorderRadius.circular(20.r),
                  hint: MyTextPoppines(
                    text: "select city",
                    fontSize: 15.sp,
                    color: AppColors.black.withOpacity(0.7),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  dropdownColor: AppColors.whiteF9F9F9,
                  //List of items present in list
                  items: cities.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
