import 'package:application/assets/constants.dart';
import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/routes/home/controllers/cards_controller.dart';
import 'package:application/routes/home/view/widgets/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsPage extends GetView<CardsController> {
  late final Color color;

  CardsPage({Key? key, required this.color}) : super(key: key) {
    Get.put(CardsController());
  }

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
                      controller.obx(
                          (state) => Obx(() => ListView.builder(
                                itemBuilder: (BuildContext, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 3),
                                    child: Section(
                                      opacity: 0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                              foregroundImage: NetworkImage(
                                                  controller.elements
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          controller
                                                              .cards[index]
                                                              .title)
                                                      .figure)),
                                          Text(
                                            controller.elements
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    controller
                                                        .cards[index].title)
                                                .text
                                                .toString(),
                                            style: GoogleFonts.raleway(
                                                color: color,
                                                fontSize: 16.w,
                                                fontWeight: FontWeight.w800),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: controller.cards.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(5),
                                scrollDirection: Axis.vertical,
                              )),
                          onLoading: Center(
                            child: CircularProgressIndicator(
                              color: Constants.purple,
                            ),
                          ),
                          onError: (e) => Center(
                                child: CircularProgressIndicator(
                                  color: Constants.purple,
                                ),
                              ))
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
                        controller.toRegisterCard();
                      },
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
}
