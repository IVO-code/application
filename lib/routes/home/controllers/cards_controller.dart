import 'package:application/data/card/card_model.dart';
import 'package:application/data/card/datasource/card_remote.dart';
import 'package:application/data/element/datasource/element_remote.dart';
import 'package:application/data/element/element_model.dart';
import 'package:application/routes/register_cards/view/register_cards_view.dart';
import 'package:get/get.dart';

class CardsController extends GetxController with StateMixin {
  List<Elements> elements = [];
  RxList<Cards> cards = RxList<Cards>();

  CardsController() {}

  void toRegisterCard() async {
    await Get.to(() => RegisterCardsView());
    _load();
  }

  void _load() async {
    change(null, status: RxStatus.loading());
    await _loadElements();
    await _loadCards();
  }

  _loadElements() async {
    elements.clear();
    try {
      elements = await ElementRemote().findAllElements();
    } catch (e) {}
  }

  _loadCards() async {
    change(null, status: RxStatus.loading());
    cards.clear();
    try {
      List<Cards> cards = await CardRemote().findAllCards();
      if (cards != null)
        for (var i = 0; i < cards.length; i++) this.cards.add(cards[i]);
      change(cards, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error("Erro"));
    }
  }
}
