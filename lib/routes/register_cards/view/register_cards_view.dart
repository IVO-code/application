import 'dart:math';
import 'dart:ui';

import 'package:application/assets/constants.dart';
import 'package:application/assets/grid/item_card.dart';
import 'package:application/routes/home/view/widgets/background.dart';
import 'package:application/routes/register_cards/controllers/register_cards_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preload_page_view/preload_page_view.dart';

class RegisterCardsView extends GetView<RegisterCardsController> {
  RegisterCardsView() {}

  @override
  Widget build(Object context) {
    Get.put(RegisterCardsController(context: context as BuildContext));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.purple,
        body: SafeArea(
            child: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Background(
                color: Constants.purple,
              ),
            ),
            ScrollConfiguration(
                behavior: MyBehavior(),
                child: Expanded(
                    child: controller.obx(
                        onLoading: Center(
                          child: CircularProgressIndicator(
                            color: Constants.background,
                          ),
                        ),
                        (state) => Stack(children: [
                              PreloadPageView.builder(
                                  onPageChanged: ((value) =>
                                      controller.pagechange(value)),
                                  controller: controller.pagecontroller,
                                  itemCount: 3,
                                  scrollDirection: Axis.vertical,
                                  preloadPagesCount: 3,
                                  itemBuilder: (context, mainIndex) {
                                    var rows = [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: _getTitle(
                                                  "Tudo começa com uma pergunta...",
                                                  true),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 36),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Obx(
                                                          () => PreloadPageView
                                                              .builder(
                                                                  itemCount:
                                                                      (controller
                                                                                  .question_widgets.length *
                                                                              0) +
                                                                          4,
                                                                  preloadPagesCount:
                                                                      3,
                                                                  controller:
                                                                      controller
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
                                                                            .question_widgets[
                                                                        index];
                                                                  }),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Obx(
                                                          () => PreloadPageView
                                                              .builder(
                                                                  itemCount:
                                                                      (controller
                                                                                  .question_widgets.length *
                                                                              0) +
                                                                          4,
                                                                  preloadPagesCount:
                                                                      3,
                                                                  controller:
                                                                      controller
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
                                                                            .question_widgets[
                                                                        index +
                                                                            4];
                                                                  }),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: _getTitle(
                                                  "Agora escolha as respostas..",
                                                  false),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 36),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Obx(
                                                          () => PreloadPageView
                                                              .builder(
                                                                  itemCount:
                                                                      (controller
                                                                                  .answers_widgets.length *
                                                                              0) +
                                                                          4,
                                                                  preloadPagesCount:
                                                                      3,
                                                                  controller:
                                                                      controller
                                                                              .controllers[
                                                                          0][0],
                                                                  physics:
                                                                      ClampingScrollPhysics(),
                                                                  onPageChanged:
                                                                      (page) {
                                                                    controller
                                                                        .animatePage(
                                                                            0,
                                                                            1,
                                                                            page);
                                                                  },
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return controller
                                                                            .answers_widgets[
                                                                        index];
                                                                  }),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Obx(
                                                          () => PreloadPageView
                                                              .builder(
                                                                  itemCount:
                                                                      (controller
                                                                                  .answers_widgets.length *
                                                                              0) +
                                                                          4,
                                                                  preloadPagesCount:
                                                                      3,
                                                                  controller:
                                                                      controller
                                                                              .controllers[
                                                                          0][1],
                                                                  physics:
                                                                      ClampingScrollPhysics(),
                                                                  onPageChanged:
                                                                      (page) {
                                                                    controller
                                                                        .animatePage(
                                                                            0,
                                                                            0,
                                                                            page);
                                                                  },
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return controller
                                                                            .answers_widgets[
                                                                        index +
                                                                            4];
                                                                  }),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ]),
                                      Obx(() => Container(
                                            margin: EdgeInsets.all(64),
                                            child: ItemCard(
                                                child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                ),
                                                Text("Resumo",
                                                    style: GoogleFonts.raleway(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Constants.purple,
                                                        fontSize: 34)),
                                                SizedBox(
                                                  height: 44,
                                                ),
                                                controller.question.value !=
                                                        null
                                                    ? CircleAvatar(
                                                        foregroundImage:
                                                            NetworkImage(
                                                                controller
                                                                    .question
                                                                    .value!
                                                                    .figure))
                                                    : Container(),
                                                Text(
                                                    textAlign: TextAlign.center,
                                                    controller.question.value ==
                                                            null
                                                        ? "Nenhuma pergunta selecionada..."
                                                        : controller.question
                                                            .value!.text,
                                                    style: GoogleFonts.raleway(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Constants.purple,
                                                        fontSize: 24)),
                                                SizedBox(
                                                  height: 48,
                                                ),
                                                Expanded(
                                                    child: ListView.builder(
                                                  // Let the ListView know how many items it needs to build.
                                                  itemCount: controller
                                                      .selected.length,
                                                  // Provide a builder function. This is where the magic happens.
                                                  // Convert each item into a widget based on the type of item it is.
                                                  itemBuilder:
                                                      (context, index) {
                                                    final item = controller
                                                        .selected[index];

                                                    return ListTile(
                                                      leading: CircleAvatar(
                                                          foregroundImage:
                                                              NetworkImage(
                                                                  item.figure)),
                                                      title: Text(item.text,
                                                          style: GoogleFonts
                                                              .raleway(
                                                                  color: Constants
                                                                      .purple,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      18)),
                                                    );
                                                  },
                                                ))
                                              ],
                                            )),
                                          )),
                                    ];
                                    return rows[mainIndex];
                                  }),
                              Positioned(
                                  bottom: 24,
                                  left: 16,
                                  right: 16,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Obx(
                                        () => GestureDetector(
                                            onTap: () {
                                              controller.showRegisterDialog();
                                            },
                                            child: controller.page.value == 2
                                                ? Container()
                                                : Container(
                                                    margin: EdgeInsets.all(8),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                          sigmaX: 12.0,
                                                          sigmaY: 12.0,
                                                        ),
                                                        child: Container(
                                                          width: 120,
                                                          height: 40,
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Constants
                                                                      .purple
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              90.0),
                                                                  border: Border
                                                                      .all(
                                                                    width: 1.5,
                                                                    color: Constants
                                                                        .background
                                                                        .withOpacity(
                                                                            0.2),
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
                                                                  Icons.brush,
                                                                  color: Constants
                                                                      .background,
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                        "Criar",
                                                                        style: GoogleFonts.raleway(
                                                                            color:
                                                                                Constants.background,
                                                                            fontWeight: FontWeight.w800,
                                                                            fontSize: 18))),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                      ),
                                      Obx(() => GestureDetector(
                                            excludeFromSemantics:
                                                controller.page.value == -15,
                                            onTap: () {
                                              if (controller.page.value == 2)
                                                controller.saveCard();
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
                                                      color: Constants.purple
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Constants
                                                            .background
                                                            .withOpacity(0.2),
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
                                                                  : controller.page
                                                                              .value ==
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
                                                              fillColor: Constants
                                                                  .background),
                                                      textAlign:
                                                          TextAlign.center,
                                                      onChanged: (_) =>
                                                          controller.input(),
                                                      cursorColor:
                                                          Constants.background,
                                                      controller:
                                                          controller.search,
                                                      style:
                                                          GoogleFonts.raleway(
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
                                  )),
                            ]))))
          ],
        )));
  }

  Widget _getTitle(String title, bool? back) {
    back ??= true;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(color: Constants.purple, boxShadow: [
          BoxShadow(
              blurRadius: 3,
              offset: Offset(0, 4),
              color: Constants.black.withAlpha(70))
        ]),
        height: 125.h,
        alignment: Alignment.topLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              back
                  ? IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Constants.background,
                    )
                  : Container(),
              Flexible(
                  child: Text(title,
                      style: GoogleFonts.raleway(
                        color: Constants.background,
                        fontSize: 32,
                      ))),
              SizedBox(
                height: 1,
              )
            ]),
      ),
    );
  }
}
