import 'package:application/assets/widgets/custom_text_button.dart';
import 'package:application/ui/forms/cards/cards_form.dart';
import 'package:application/ui/home/pages/api_controller.dart';
import 'package:application/ui/home/widgets/section.dart';
import 'package:application/ui/sections/section_card.dart';
import 'package:application/ui/sections/section_card.dart';
import 'package:application/ui/home/pages/cards/cards_controller.dart';
import 'package:application/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsPage extends GetView<ApiController> {
  late final Color color;

  CardsPage({Key? key, required this.color}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: Constants.purple,
        child: Obx(
          () => controller.cards.length > 0
              ? ListView.builder(
                  itemCount: controller.cards.length,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 28,
                                    ),
                                    Section(
                                      circularity: 50,
                                      vertical: 6,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              controller.find_cards(value);
                                            },
                                            autofocus: false,
                                            cursorColor: Constants.purple,
                                            decoration: InputDecoration(
                                                fillColor: Constants.purple
                                                    .withAlpha(15),
                                                hintStyle: TextStyle(
                                                    color: Constants.purple),
                                                border: InputBorder.none,
                                                hintText: "Filtrar cards",
                                                icon: Icon(
                                                  Icons.search,
                                                  color: Constants.purple,
                                                ),
                                                focusColor: Constants.purple,
                                                iconColor: Constants.purple),
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
                                      controller.toRegisterCard();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SectionCard(
                              card: controller.cards[index],
                              color: Constants.purple,
                              white: true,
                              ontap: () {
                                Get.to(() =>
                                    CardForm(card: controller.cards[index]));
                              },
                            )
                          ]);
                    } else {
                      if (index == controller.cards.length - 1) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionCard(
                                card: controller.cards[index],
                                color: Constants.purple,
                                white: true,
                                ontap: () {
                                  Get.to(() =>
                                      CardForm(card: controller.cards[index]));
                                },
                              ),
                              SizedBox(
                                height: 200,
                              )
                            ]);
                      } else {
                        return SectionCard(
                          card: controller.cards[index],
                          color: Constants.purple,
                          white: true,
                          ontap: () {
                            Get.to(
                                () => CardForm(card: controller.cards[index]));
                          },
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
                                circularity: 50,
                                vertical: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        controller.find_cards(value);
                                      },
                                      autofocus: false,
                                      cursorColor: Constants.purple,
                                      decoration: InputDecoration(
                                          fillColor:
                                              Constants.purple.withAlpha(15),
                                          hintStyle: TextStyle(
                                              color: Constants.purple),
                                          border: InputBorder.none,
                                          hintText: "Filtrar cards",
                                          icon: Icon(
                                            Icons.search,
                                            color: Constants.purple,
                                          ),
                                          focusColor: Constants.purple,
                                          iconColor: Constants.purple),
                                      style: GoogleFonts.raleway(
                                          color: color,
                                          fontSize: 16.w,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
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
                                controller.toRegisterCard();
                              },
                            ),
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
                                    "Nenhum card encontrado...",
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
