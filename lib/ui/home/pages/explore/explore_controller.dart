import 'package:application/model/card_model.dart';
import 'package:application/services/card_service.dart';
import 'package:application/services/element_service.dart';
import 'package:application/model/element_model.dart';
import 'package:application/ui/register/cards/register_cards_view.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController with StateMixin {
  List<Elements> elements = [];
  RxList<Cards> cards = RxList<Cards>();

  ExploreController() {}

  void toRegisterCard() async {
    await Get.to(() => RegisterCardsView());
    //_load();
  }

  void _load() async {
    change(null, status: RxStatus.loading());
    //await _loadElements();
    //await _loadCards();
  }

  _loadElements() async {
    elements.clear();
    try {
      elements = await ElementService().findAllElements();
    } catch (e) {}
  }

  _loadCards() async {
    change(null, status: RxStatus.loading());
    cards.clear();
    try {
      List<Cards> cards = await CardService().findAllCards();
      if (cards != null)
        for (var i = 0; i < cards.length; i++) this.cards.add(cards[i]);
      change(cards, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error("Erro"));
    }
  }
}
