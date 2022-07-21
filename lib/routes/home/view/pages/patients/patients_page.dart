import 'dart:ui';

import 'package:application/assets/constants.dart';
import 'package:application/routes/home/view/pages/cards/widgets/category_boxes.dart';
import 'package:application/routes/home/view/pages/cards/widgets/discover_card.dart';
import 'package:application/routes/home/view/pages/cards/widgets/discover_small_card.dart';
import 'package:application/routes/home/view/widgets/background.dart';
import 'package:application/routes/home/view/widgets/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientsPage extends GetView {
  late Color color;

  PatientsPage({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          child: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pacientes",
                        style: GoogleFonts.raleway(
                            color: Constants.background,
                            fontSize: 50.w,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            size: 16.w,
                            color: Constants.background,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Centro de Saúde Anita Garibaldi",
                            style: GoogleFonts.raleway(
                                color: Constants.background,
                                fontSize: 16.w,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ]),
              ),
              Section(child: Text("Teste"))
            ],
          ),
        ],
      )),
    );
  }

  void onSeeAllTapped() {}

  void onSleepMeditationTapped() {
    //Get.to(() => DetailPage(), transition: Transition.rightToLeft);
  }

  void onDepressionHealingTapped() {}

  void onSearchIconTapped() {}
}
