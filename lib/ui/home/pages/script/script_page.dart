import 'dart:ui';

import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/ui/home/pages/api_controller.dart';
import 'package:application/ui/home/pages/script/script_controller.dart';
import 'package:application/ui/home/widgets/section.dart';
import 'package:application/ui/sections/section_card.dart';
import 'package:application/util.dart';
import 'package:application/ui/sections/section_script.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ScriptPage extends GetView<ApiController> {
  late Color color;

  ScriptPage({
    Key? key,
    required this.color,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: Constants.pink,
        child: Obx(
          () => controller.scripts.length > 0
              ? ListView.builder(
                  itemCount: controller.scripts.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 35.h, left: 20.w, right: 20.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Roteiros",
                                      style: GoogleFonts.raleway(
                                          color: Constants.background,
                                          fontSize: 50.w,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Fluxo de atendimento recomendado por especialistas",
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 28,
                                    ),
                                    Section(
                                      vertical: 6,
                                      circularity: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              controller.find_scripts(value);
                                            },
                                            autofocus: false,
                                            cursorColor: Constants.pink,
                                            decoration: InputDecoration(
                                                fillColor: Constants.pink
                                                    .withAlpha(15),
                                                hintStyle: TextStyle(
                                                    color: Constants.pink),
                                                border: InputBorder.none,
                                                hintText: "Filtrar roteiros",
                                                icon: Icon(
                                                  Icons.search,
                                                  color: Constants.pink,
                                                ),
                                                focusColor: Constants.pink,
                                                iconColor: Constants.pink),
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
                                    press: () async {
                                      controller.toRegisterScript();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SectionScript(
                              script: controller.scripts[index],
                              color: Constants.pink,
                              white: true,
                              ontap: () {},
                            )
                          ]);
                    } else {
                      if (index == controller.scripts.length - 1) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionScript(
                                script: controller.scripts[index],
                                color: Constants.pink,
                                white: true,
                                ontap: () {},
                              ),
                              SizedBox(
                                height: 200,
                              )
                            ]);
                      } else {
                        return SectionScript(
                          script: controller.scripts[index],
                          color: Constants.pink,
                          white: true,
                          ontap: () {},
                        );
                      }
                    }
                  },
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 35.h, left: 20.w, right: 20.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Roteiros",
                                style: GoogleFonts.raleway(
                                    color: Constants.background,
                                    fontSize: 50.w,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Fluxo de atendimento recomendado por especialistas",
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
                                vertical: 6,
                                circularity: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        controller.find_scripts(value);
                                      },
                                      autofocus: false,
                                      cursorColor: Constants.pink,
                                      decoration: InputDecoration(
                                          fillColor:
                                              Constants.pink.withAlpha(15),
                                          hintStyle:
                                              TextStyle(color: Constants.pink),
                                          border: InputBorder.none,
                                          hintText: "Filtrar scripts",
                                          icon: Icon(
                                            Icons.search,
                                            color: Constants.pink,
                                          ),
                                          focusColor: Constants.pink,
                                          iconColor: Constants.pink),
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
                              press: () async {
                                controller.toRegisterScript();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Flexible(
                          child: Center(
                              heightFactor: 5,
                              child: controller.obx(
                                (state) => Container(),
                                onLoading: CircularProgressIndicator(
                                  color: Constants.background,
                                ),
                                onError: (e) => Text(
                                    "Nenhum script encontrado...",
                                    style: GoogleFonts.raleway(
                                        color: Constants.background,
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.bold)),
                              )))
                    ]),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    controller.load();
  }
}
