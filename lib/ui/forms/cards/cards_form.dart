import 'package:application/assets/grid/widget_grid.dart';
import 'package:application/model/card_model.dart';
import 'package:application/services/script_service.dart';
import 'package:application/ui/forms/cards/card_form_controller.dart';
import 'package:application/ui/home/widgets/section.dart';
import 'package:application/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class CardForm extends GetView<CardFormController> {
  late Cards card;
  late Color color;
  CardForm({required this.card}) {
    color = Constants.randomColor();
    Get.put<CardFormController>(CardFormController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 100),
              child: Column(
                children: [
                  Flexible(
                      child: Section(
                          glass: false,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 7,
                                child: Image(
                                    image: NetworkImage(card.title!.figure)),
                              ),
                              Flexible(
                                child: Text(card.title!.text,
                                    style: GoogleFonts.raleway(
                                        color: color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                              )
                            ],
                          ))),
                  SizedBox(
                    height: 30,
                  ),
                  Flexible(
                      flex: 2,
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: GridView.builder(
                            itemCount: card.options!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1),
                            itemBuilder: (context, index) => Container(
                                padding: EdgeInsets.only(top: 24),
                                child: GestureDetector(
                                  onTap: () {
                                    ScriptService().attendance(
                                        card: card,
                                        element: card.options![index]!);
                                    Get.back();
                                  },
                                  child: Section(
                                      vertical: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Image(
                                                image: NetworkImage(card
                                                    .options![index]!.figure)),
                                          ),
                                          Flexible(
                                            child: Text(
                                                card.options![index]!.text,
                                                style: GoogleFonts.raleway(
                                                    color: color,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          )
                                        ],
                                      )),
                                ))),
                      )),
                ],
              ))),
    );
  }
}
