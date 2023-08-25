import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/features/our%20services/screens/our_service_card.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:provider/provider.dart';

import '../../../provider/notifiers/our_services_notifier.dart';


class OurServicesCardHomeScreenView extends StatelessWidget {
  final Function(BuildContext context) effect;
  const OurServicesCardHomeScreenView({super.key, required this.effect});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final ourServicesNotifier = context.watch<OurServicesNotifier>();

    final ourservices = ourServicesNotifier.services.services;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextPoppines(
          text: "Our Services",
          fontWeight: FontWeight.w600,
          fontSize: width / 23,
        ),
        ourservices != null
            ? SizedBox(
                height: height / 2.30,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: ourservices.length,
                  itemBuilder: (context, index) {
                    return OurServicesCard(
                      index: index,
                    );
                  },
                ),
              )
            : effect(context),
        SizedBox(height: height / 50),
      ],
    );
  }
}
