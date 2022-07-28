import 'package:application/model/card_model.dart';
import 'package:application/services/card_service.dart';
import 'package:application/services/element_service.dart';
import 'package:application/ui/register/cards/register_cards_view.dart';
import 'package:application/util.dart';
import 'package:get/get.dart';

class CardsController extends GetxController with StateMixin {
  List<Cards> _cards = [];
  RxList<Cards> cards = RxList<Cards>();

  CardsController() {
    _load();
  }

  void toRegisterCard() async {
    await Get.to(() => RegisterCardsView());
    // _load();
  }

  void _load() async {
    change(null, status: RxStatus.loading());
    await _loadCards();
  }

  void _find(string) async {
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
}
