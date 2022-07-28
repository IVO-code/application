import 'dart:math';
import 'dart:ui';

import 'package:application/ui/register/script/register_script_controller.dart';
import 'package:application/util.dart';
import 'package:application/assets/grid/item_card.dart';
import 'package:application/ui/home/widgets/background.dart';
import 'package:application/ui/register/cards/register_cards_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preload_page_view/preload_page_view.dart';

class RegisterScriptsView extends GetView<RegisterScriptsController> {
  RegisterScriptsView() {
    Get.put<RegisterScriptsController>(RegisterScriptsController());
  }

  @override
  Widget build(Object context) {
    controller.context = context as BuildContext;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.pink,
        body: SafeArea(
            child: Container(
                color: Color.lerp(Constants.background, Constants.pink, 0.7),
                child: Stack(
                  children: [
                    Background(
                      color: Constants.pink,
                      flat: true,
                      h1: 0.1,
                      w1: 0.7,
                      h2: 0.5,
                      h3: 0.7,
                      h4: 0.1,
                      w4: 0.1,
                      h5: 0.8,
                    ),
                    ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: controller.obx(
                            onLoading: Center(
                              child: CircularProgressIndicator(
                                color: Constants.background,
                              ),
                            ),
                            (state) => Stack(children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (controller.page.value == 0) {
                                              Get.back(closeOverlays: true);
                                            } else {
                                              controller.page.value--;
                                            }
                                          },
                                          icon: Icon(Icons.arrow_back),
                                          color: Constants.background,
                                          padding: EdgeInsets.all(30),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Obx(() => Text(
                                              controller.page.value == 0
                                                  ? "Escolha um título..."
                                                  : controller.selected
                                                              .length >=
                                                          2
                                                      ? "Aperte no botão ao\nlado para salvar!"
                                                      : "Agora escolha os cards...",
                                              style: GoogleFonts.raleway(
                                                color: Constants.background,
                                                fontSize: 32,
                                              ))),
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 120, top: 50),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Obx(
                                                      () => PreloadPageView
                                                          .builder(
                                                              itemCount: (controller
                                                                          .page.value ==
                                                                      0
                                                                  ? (controller
                                                                              .question_widgets
                                                                              .length /
                                                                          2)
                                                                      .ceil()
                                                                  : (controller
                                                                              .answers_widgets
                                                                              .length /
                                                                          2)
                                                                      .ceil()),
                                                              preloadPagesCount:
                                                                  3,
                                                              controller: controller
                                                                      .controllers[
                                                                  1][0],
                                                              physics:
                                                                  ClampingScrollPhysics(),
                                                              onPageChanged:
                                                                  (page) {
                                                                controller
                                                                    .animatePage(
                                                                        1,
                                                                        1,
                                                                        page);
                                                              },
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return controller
                                                                            .page
                                                                            .value ==
                                                                        0
                                                                    ? controller
                                                                            .question_widgets[
                                                                        index *
                                                                            2]
                                                                    : controller
                                                                            .answers_widgets[
                                                                        index *
                                                                            2];
                                                              }),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Obx(
                                                      () => PreloadPageView
                                                          .builder(
                                                              itemCount: (controller
                                                                          .page
                                                                          .value ==
                                                                      0
                                                                  ? (controller.question_widgets.length /
                                                                          2)
                                                                      .floor()
                                                                  : (controller
                                                                              .answers_widgets
                                                                              .length /
                                                                          2)
                                                                      .floor()),
                                                              controller: controller
                                                                      .controllers[
                                                                  1][1],
                                                              physics:
                                                                  ClampingScrollPhysics(),
                                                              onPageChanged:
                                                                  (page) {
                                                                controller
                                                                    .animatePage(
                                                                        1,
                                                                        0,
                                                                        page);
                                                              },
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return controller
                                                                            .page
                                                                            .value ==
                                                                        0
                                                                    ? controller
                                                                        .question_widgets[(index *
                                                                            2) +
                                                                        1]
                                                                    : controller
                                                                        .answers_widgets[(index *
                                                                            2) +
                                                                        1];
                                                              }),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ]),
                                  Obx(() => Positioned(
                                      bottom:
                                          controller.isvisible.value ? 100 : 24,
                                      left: 16,
                                      right: 16,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Obx(
                                            () => GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .showRegisterDialog();
                                                },
                                                child:
                                                    controller.page.value == 2
                                                        ? Container()
                                                        : Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          90),
                                                              child:
                                                                  BackdropFilter(
                                                                filter:
                                                                    ImageFilter
                                                                        .blur(
                                                                  sigmaX: 12.0,
                                                                  sigmaY: 12.0,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 120,
                                                                  height: 40,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Constants.pink.withOpacity(
                                                                              0.2),
                                                                          borderRadius: BorderRadius.circular(
                                                                              90.0),
                                                                          border:
                                                                              Border.all(
                                                                            width:
                                                                                1.5,
                                                                            color:
                                                                                Constants.background.withOpacity(0.2),
                                                                          )),
                                                                  child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .brush,
                                                                          color:
                                                                              Constants.background,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              6,
                                                                        ),
                                                                        Flexible(
                                                                            child:
                                                                                Text("Criar", style: GoogleFonts.raleway(color: Constants.background, fontWeight: FontWeight.w800, fontSize: 18))),
                                                                      ]),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                          ),
                                          Obx(() => GestureDetector(
                                                excludeFromSemantics:
                                                    controller.page.value ==
                                                        -15,
                                                onTap: () {
                                                  if (controller.page.value ==
                                                      2) controller.saveCard();
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                      sigmaX: 12.0,
                                                      sigmaY: 12.0,
                                                    ),
                                                    child: Container(
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                          color: Constants.pink
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      90.0),
                                                          border: Border.all(
                                                            width: 1.5,
                                                            color: Constants
                                                                .background
                                                                .withOpacity(
                                                                    0.2),
                                                          )),
                                                      child: Center(
                                                          child: Obx(
                                                        () => TextField(
                                                          enabled: controller
                                                                  .page.value !=
                                                              2,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText: controller
                                                                              .page
                                                                              .value ==
                                                                          0
                                                                      ? "Buscar pergunta..."
                                                                      : controller.page.value ==
                                                                              1
                                                                          ? "Buscar resposta..."
                                                                          : "Adicionar card",
                                                                  hintStyle: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Constants
                                                                          .background
                                                                          .withOpacity(
                                                                              0.7)),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  fillColor:
                                                                      Constants
                                                                          .background),
                                                          textAlign:
                                                              TextAlign.center,
                                                          onChanged: (_) =>
                                                              controller
                                                                  .input(),
                                                          cursorColor: Constants
                                                              .background,
                                                          controller:
                                                              controller.search,
                                                          style: GoogleFonts.raleway(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
                                                              color: Constants
                                                                  .background),
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ))),
                                  Obx(() => controller.selected.length >= 2 &&
                                          controller.page.value == 1
                                      ? Positioned(
                                          top: 94,
                                          right: 16,
                                          child: Obx(() => Container(
                                              padding: EdgeInsets.all(controller
                                                      .animationValue.value
                                                      .toDouble() *
                                                  0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Constants.background
                                                      .withAlpha(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Constants
                                                            .background
                                                            .withAlpha(90),
                                                        blurRadius: controller
                                                            .animationValue
                                                            .value,
                                                        spreadRadius: controller
                                                            .animationValue
                                                            .value)
                                                  ]),
                                              child: FloatingActionButton(
                                                child: Icon(
                                                  Icons.library_add,
                                                  color: Constants.pink,
                                                ),
                                                splashColor: Constants.pink,
                                                foregroundColor: Constants.pink,
                                                onPressed: (() =>
                                                    controller.saveCard()),
                                                backgroundColor:
                                                    Constants.background,
                                              ))))
                                      : Container())
                                ])))
                  ],
                ))));
  }
}
