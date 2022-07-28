import 'dart:ui';

import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/ui/home/widgets/section.dart';
import 'package:application/util.dart';
import 'package:application/ui/sections/section_script.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            child: Stack(children: [
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
                              "Seção em desenvolvimento",
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
                ],
              ),
            ],
          ),
        ])));
  }
}
