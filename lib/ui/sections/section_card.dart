import 'package:application/model/element_model.dart';
import 'package:application/util.dart';
import 'package:application/model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preload_page_view/preload_page_view.dart';

class SectionCard extends GetView {
  late Cards card;
  late bool white, detailed, asCard;
  late Color color;
  RxBool selected = true.obs;
  late Function() ontap;

  SectionCard(
      {required this.card,
      this.white = false,
      this.detailed = true,
      this.color = Constants.background,
      required this.ontap,
      this.asCard = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (!detailed) {
            selected.value = !(selected.value);
          }
          ontap();
        },
        child: asCard
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                    color: (white
                        ? Constants.background.withAlpha(150)
                        : color.withAlpha(150)),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: (white ? Constants.background : color)
                          .withOpacity(0.20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          offset: Offset(-4, 4),
                          color: Constants.black.withAlpha(30))
                    ]),
                child: Row(
                  children: [
                    Flexible(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: (white ? color : Constants.background)
                                    .withAlpha(70)),
                            child: Image.network(
                              card.title!.figure,
                              alignment: Alignment.center,
                            ),
                          )),
                    ),
                    Flexible(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(card.title!.text,
                              style: GoogleFonts.raleway(
                                  color: white ? color : Constants.background,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                        )),
                  ],
                ),
              )
            : Obx(
                () => selected.value
                    ? Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                        decoration: BoxDecoration(
                            color: (white ? Constants.background : color),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                              color: (white ? Constants.background : color)
                                  .withOpacity(0.20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-4, 4),
                                  color: Constants.black.withAlpha(30))
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: (white
                                                    ? color
                                                    : Constants.background)
                                                .withAlpha(70)),
                                        child: Image.network(
                                          card.title!.figure,
                                          height: detailed ? 75.0 : 60,
                                          width: detailed ? 75.0 : 60.0,
                                          alignment: Alignment.center,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Flexible(
                                      child: Text(card.title!.text,
                                          style: GoogleFonts.raleway(
                                              color: white
                                                  ? color
                                                  : Constants.background,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700))),
                                ],
                              ),
                              detailed
                                  ? Container(
                                      padding: EdgeInsets.only(top: 6),
                                      child: chipList(card.options!),
                                    )
                                  : Container()
                            ]),
                      )
                    : Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                        decoration: BoxDecoration(
                            color: (white
                                ? Constants.background.withAlpha(150)
                                : color.withAlpha(150)),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                              color: (white ? Constants.background : color)
                                  .withOpacity(0.20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-4, 4),
                                  color: Constants.black.withAlpha(30))
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: (white
                                                    ? color
                                                    : Constants.background)
                                                .withAlpha(70)),
                                        child: Image.network(
                                          card.title!.figure,
                                          height: detailed ? 75.0 : 60,
                                          width: detailed ? 75.0 : 60,
                                          alignment: Alignment.center,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                      child: Text(card.title!.text,
                                          style: GoogleFonts.raleway(
                                              color: white
                                                  ? color
                                                  : Constants.background,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700))),
                                ],
                              ),
                              detailed
                                  ? Container(
                                      padding: EdgeInsets.only(top: 6),
                                      child: chipList(card.options!),
                                    )
                                  : Container()
                            ]),
                      ),
              ));
  }

  chipList(List<Elements?> list) {
    List<Widget> chips = [];
    for (var i = 0; i < list.length; i++) {
      chips.add(
        _buildChip(list[i]!.text),
      );
    }
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: chips,
    );
  }

  Widget _buildChip(String label) {
    return Container(
      decoration: BoxDecoration(
          color:
              white ? color.withAlpha(50) : Constants.background.withAlpha(50),
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      child: Text(label,
          style: GoogleFonts.raleway(
              color: white ? color : Constants.background,
              fontSize: 14,
              letterSpacing: 0.1,
              fontWeight: FontWeight.w400)),
    );
  }
}
