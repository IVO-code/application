import 'dart:ui';

import 'package:application/model/element_model.dart';
import 'package:application/util.dart';
import 'package:application/model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionElement extends GetView {
  late Elements element;
  late bool white;
  late Color color;
  RxBool selected = false.obs;
  late Function() ontap;

  SectionElement(
      {required this.element,
      this.white = false,
      this.color = Constants.orange,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          selected.value = ontap();
        },
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Obx(
              () => selected.value
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Constants.background.withAlpha(70))
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Constants.background.withOpacity(0.6),
                                Constants.background.withOpacity(0.35),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              width: 2,
                              color: Constants.background.withOpacity(0.45),
                            ),
                          ),
                          child: body(),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      decoration: BoxDecoration(
                          color: Constants.background,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 2,
                            color: Constants.background.withOpacity(0.20),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                offset: Offset(-4, 4),
                                color: Constants.black.withAlpha(30))
                          ]),
                      child: body(),
                    ),
            )));
  }

  body() {
    return Row(
      children: [
        Expanded(
          child: CircleAvatar(
            minRadius: 12,
            maxRadius: 34,
            backgroundColor: Constants.inactive,
            foregroundImage: NetworkImage(element.figure),
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    element.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      color: Constants.purple,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
