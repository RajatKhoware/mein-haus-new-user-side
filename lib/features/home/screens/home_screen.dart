// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_user_side/features/estimate/screens/estimate_generation_screen.dart';
import 'package:new_user_side/res/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../provider/notifiers/estimate_notifier.dart';
import '../../../provider/notifiers/our_services_notifier.dart';
import '../../../static components/drawer/my_drawer_widget.dart';
import '../widget/estimate_home_screen_view.dart';
import '../widget/home_offer_banner_widget.dart';
import '../widget/home_page_app_bar.dart';
import '../widget/ongoing_home_screen_view.dart';
import '../widget/our_services_home_screen_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/Home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isExpanded = true;
  @override
  void initState() {
    super.initState();
    animateEstimateButton();
    getEstimate();
    getOngoingProjects();
    getOurServices();
  }

  void animateEstimateButton() {
    Timer(const Duration(seconds: 2), () {
      setState(() => _isExpanded = true);
      Timer(const Duration(seconds: 4), () {
        setState(() => _isExpanded = false);
      });
    });
  }

  Future<void> getEstimate() async {
    final notifer = context.read<EstimateNotifier>();
    await notifer.getEstimateWork();
  }

  Future<void> getOngoingProjects() async {
    final notifer = context.read<EstimateNotifier>();
    await notifer.getOngoingProjects();
  }

  Future<void> getOurServices() async {
    final notifer = context.read<OurServicesNotifier>();
    await notifer.getOurServices();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 16),
        child: HomePageAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 1.0,
            color: AppColors.grey.withOpacity(0.2),
          ),
          SizedBox(height: height / 120),
          const HomeOfferBanner(),
          SizedBox(height: height / 120),
          Divider(
            thickness: 1.0,
            color: AppColors.grey.withOpacity(0.2),
          ),
          SizedBox(height: height / 120),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: AppColors.grey.withOpacity(0.05),
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height / 80),
                    EstimateCardHomeScreenView(effect: _buildShimmerEffect),
                    SizedBox(height: height / 30),
                    OngoingCardHomeScreenView(effect: _buildShimmerEffect),
                    SizedBox(height: height / 30),
                    OurServicesCardHomeScreenView(effect: _buildShimmerEffect),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _isExpanded ? width / 2.35 : 50,
          height: height / 16,
          decoration: BoxDecoration(
            borderRadius: _isExpanded
                ? BorderRadius.circular(width / 12)
                : BorderRadius.circular(width / 3),
            color: AppColors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (_isExpanded)
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: width / 40, left: width / 20),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        EstimateGenerationScreen.routeName,
                        arguments: true,
                      ),
                      child: MyTextPoppines(
                        text: "Create New Est",
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        fontSize: width / 32,
                      ),
                    ),
                  ),
                ),
              Icon(
                Icons.add_circle_outline,
                color: AppColors.white,
                size: width / 16,
              ),
              if (_isExpanded) SizedBox(width: width / 40),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: width / 2,
              height: height / 3.5,
              margin: EdgeInsets.only(right: width / 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width / 30),
                color: AppColors.white,
              ),
            ),
            Container(
              width: width / 2,
              height: height / 3.5,
              margin: EdgeInsets.only(right: width / 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width / 30),
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
