import 'package:application/model/card_model.dart';
import 'package:application/model/script_model.dart';
import 'package:application/services/card_service.dart';
import 'package:application/services/script_service.dart';
import 'package:application/ui/forms/cards/cards_form.dart';
import 'package:application/ui/home/home_controller.dart';
import 'package:application/ui/home/pages/pages_controller.dart';
import 'package:application/ui/home/widgets/section.dart';
import 'package:application/ui/register/cards/register_cards_controller.dart';
import 'package:application/ui/register/cards/register_cards_view.dart';
import 'package:application/ui/register/script/register_script_controller.dart';
import 'package:application/ui/register/script/register_script_view.dart';
import 'package:application/ui/sections/section_card.dart';
import 'package:application/ui/sections/section_script.dart';
import 'package:application/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ApiController extends GetxController with StateMixin {
  List<Cards> _cards = [];
  List<Scripts> _scripts = [];
  RxList<Cards> cards = RxList<Cards>();
  RxList<Scripts> scripts = RxList<Scripts>();
  RxList<Widget> explore = RxList<Widget>();

  ApiController() {
    load();
  }

  void toRegisterCard() async {
    Cards? c = await Get.to(() => RegisterCardsView());
    Get.delete<RegisterCardsController>();

    if (c != null) {
      _cards.add(c);
      cards.add(c);
    }
  }

  void toRegisterScript() async {
    Scripts? s = await Get.to(() => RegisterScriptsView());
    Get.delete<RegisterScriptsController>();
    if (s != null) {
      _scripts.add(s);

      scripts.add(s);
    }
  }

  void load() async {
    change(null, status: RxStatus.loading());
    await _loadCards();
    await _loadScripts();
    await _loadExplore();
  }

  void find_cards(string) async {
    change(null, status: RxStatus.loading());

    cards.clear();
    try {
      List<Cards> cards = _cards
          .where(
              (i) => i.title!.text.toUpperCase().contains(string.toUpperCase()))
          .toList();

      for (var i = 0; i < cards.length; i++) {
        this.cards.add(cards[i]);
      }
      change(cards, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void find_scripts(string) async {
    change(null, status: RxStatus.loading());

    scripts.clear();
    try {
      List<Scripts> scripts = _scripts
          .where(
              (i) => i.title!.text.toUpperCase().contains(string.toUpperCase()))
          .toList();

      for (var i = 0; i < scripts.length; i++) {
        this.scripts.add(scripts[i]);
      }
      change(scripts, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  _loadExplore() async {
    explore.clear();

    for (Cards card in _cards) {
      explore.add(SectionCard(
        card: card,
        asCard: true,
        ontap: () {
          Get.to(() => CardForm(card: card));
        },
        detailed: false,
        white: false,
        color: Constants.randomColor(),
      ));
    }

    for (Scripts script in _scripts) {
      explore.add(SectionScript(
        script: script,
        asCard: true,
        ontap: () {},
        detailed: false,
        white: false,
        color: Constants.randomColor(),
      ));
    }
    explore.shuffle();

    explore.insert(
        0,
        Container(
          padding: EdgeInsets.only(top: 6),
          child: GestureDetector(
              onTap: () {
                HomeController p = Get.find<HomeController>();
                p.setIndex(1);
              },
              child: Section(
                  glass: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Cards de comunicação",
                        style: GoogleFonts.raleway(
                            color: Constants.purple,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      Icon(
                        Icons.table_view,
                        color: Constants.purple,
                        size: 40,
                      )
                    ],
                  ))),
        ));
    explore.insert(
        3,
        Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "Explorar",
                  style: GoogleFonts.raleway(
                      color: Constants.orange,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: Text(
                  "Nunca foi tão fácil se comunicar!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      color: Constants.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
    explore.insert(
        7,
        Container(
          padding: EdgeInsets.only(top: 6),
          child: GestureDetector(
              onTap: () {
                HomeController p = Get.find<HomeController>();
                p.setIndex(2);
              },
              child: Section(
                  glass: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Roteiros de atendimento",
                        style: GoogleFonts.raleway(
                            color: Constants.pink,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                      Icon(
                        Icons.paste,
                        color: Constants.pink,
                        size: 40,
                      )
                    ],
                  ))),
        ));
  }

  _loadCards() async {
    change(null, status: RxStatus.loading());
    _cards.clear();
    cards.clear();
    try {
      _cards = await CardService().findAllCards();
      for (var i = 0; i < _cards.length; i++) {
        cards.add(_cards[i]);
      }
      change(cards, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  _loadScripts() async {
    change(null, status: RxStatus.loading());
    _scripts.clear();
    scripts.clear();
    try {
      _scripts = await ScriptService().findAllScripts();
      for (var i = 0; i < _scripts.length; i++) {
        scripts.add(_scripts[i]);
      }
      change(scripts, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
