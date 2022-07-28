import 'package:application/model/card_model.dart';
import 'package:application/model/element_model.dart';
import 'package:application/util.dart';
import 'package:application/model/script_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preload_page_view/preload_page_view.dart';

class SectionScript extends GetView {
  late Scripts script;
  late bool white, detailed, asCard;
  late Color color;
  late Function() ontap;

  SectionScript(
      {required this.script,
      this.white = false,
      this.detailed = true,
      this.color = Constants.background,
      required this.ontap,
      this.asCard = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: asCard
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: BoxDecoration(
                  color: white ? Constants.background : color,
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
                        Flexible(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          (white ? color : Constants.background)
                                              .withAlpha(70)),
                                  child: Image.network(
                                    script.title!.figure,
                                    alignment: Alignment.center,
                                  ),
                                ))),
                        Flexible(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(script.title!.text,
                                  style: GoogleFonts.raleway(
                                      color:
                                          white ? color : Constants.background,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            )),
                      ],
                    ),
                  ]),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: BoxDecoration(
                  color: white ? Constants.background : color,
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
                                  color: (white ? color : Constants.background)
                                      .withAlpha(70)),
                              child: Image.network(
                                script.title!.figure,
                                height: 75.0,
                                width: 75.0,
                                alignment: Alignment.center,
                              ),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                            child: Text(script.title!.text,
                                style: GoogleFonts.raleway(
                                    color: white ? color : Constants.background,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700))),
                      ],
                    ),
                    detailed
                        ? Container(
                            padding: EdgeInsets.only(top: 6),
                            child: chipList(script.cards!),
                          )
                        : Container()
                  ]),
            ),
    );
  }

  chipList(List<Cards?> list) {
    List<Widget> chips = [];
    for (var i = 0; i < list.length; i++) {
      chips.add(
        _buildChip(list[i]!.title!.figure, list[i]!.title!.text),
      );
    }
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: chips,
    );
  }

  Widget _buildChip(String label, String label2) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: white
                    ? color.withAlpha(50)
                    : Constants.background.withAlpha(50)),
            child: Row(
              children: [
                Image.network(
                  label,
                  width: 40.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(label2,
                    style: GoogleFonts.raleway(
                        color: white ? color : Constants.background,
                        fontSize: 12,
                        fontWeight: FontWeight.w700))
              ],
            )));
  }
}
