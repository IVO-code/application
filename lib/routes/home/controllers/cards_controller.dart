import 'package:application/routes/register_cards/view/register_cards_view.dart';
import 'package:get/get.dart';

class CardsController extends GetxController with StateMixin {
  void toRegisterCard() async {
    await Get.to(() => RegisterCardsView());
    update();
  }
}
