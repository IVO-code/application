import 'dart:ui';

import 'package:application/assets/constants.dart';
import 'package:application/assets/widgets/custom_text_button.dart';
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

class CardsPage extends GetView {
  late Color color;

  CardsPage({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: Container(
          child: Stack(
        children: [
          Background(color: color, image: "lib/assets/image/bg_2.png"),
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 35.h, left: 20.w, right: 20.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cards",
                        style: GoogleFonts.raleway(
                            color: Constants.background,
                            fontSize: 50.w,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cartões de comunicação\nalternativa",
                        style: GoogleFonts.raleway(
                            color: Constants.background,
                            fontSize: 16.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
              Stack(
                alignment: Alignment.center,
                fit: StackFit.passthrough,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 28,
                      ),
                      Section(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Meus cards",
                              style: GoogleFonts.raleway(
                                  color: color,
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 38,
                    child: CustomTextButton(
                      selected: true,
                      title: "Criar",
                      icon: Icons.brush,
                      color: color,
                      filled: true,
                      detailed: true,
                      press: () {},
                    ),
                  ),
                ],
              ),
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
