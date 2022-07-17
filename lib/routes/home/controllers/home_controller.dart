import 'package:application/assets/constants.dart';
import 'package:application/data/token/token_model.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:application/data/user/datasource/user_remote.dart';
import 'package:application/data/user/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin {
  late UserRepository repository = UserRemote();

  List<Color> colors = [
    Constants.orange,
    Constants.purple,
    Constants.pink,
    Constants.turquoise,
  ];

  Color _actualColor = Color(0xFF000000);
  RxInt index = 0.obs;

  late PageController pageController;

  HomeController() {
    _actualColor = colors[0];
    hasLogin();
    pageController = PageController();
  }

  hasLogin() async {
    change(null, status: RxStatus.loading());
    if (await TokenSecureStorage.hasToken()) {
      change(null, status: RxStatus.success());
    } else {
      setIndex(0);
      change(null, status: RxStatus.error("token"));
    }
    update();
  }

  Color getColor() {
    return colors[index.value];
  }

  Color getColorx(int index) {
    return colors[index];
  }

  void reset() {
    hasLogin();
    update();
  }

  void toProfile() async {
    await Get.toNamed("/profile", arguments: [_cStr()]);
    reset();
  }

  void toAuthentication() async {
    await Get.toNamed("/authentication", arguments: [_cStr()]);
    reset();
  }

  String _cStr() {
    String colorString = getColor().toString();
    return colorString.split('(0x')[1].split(')')[0];
  }

  void setIndex(int i) {
    index.value = i;
    pageController.animateToPage(
      i,
      duration: Duration(milliseconds: 200),
      curve: Curves.decelerate,
    );

    refresh();
  }
}
