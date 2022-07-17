import 'package:application/assets/constants.dart';
import 'package:application/data/token/token_model.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:application/data/user/datasource/user_remote.dart';
import 'package:application/data/user/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController with StateMixin {
  late final RxInt index;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late UserRepository repository = UserRemote();

  SignupController({required this.index}) {
    change(null, status: RxStatus.empty());
  }

  login() {
    index.value = 0;
    reset();
  }

  void signup() async {
    change(null, status: RxStatus.loading());
    try {
      Token token = await repository.login(username.text, password.text);
      TokenSecureStorage.setToken(token);
      change(null, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error("login"));
    }
  }

  void reset() {
    password.clear();
    username.clear();
    change(null, status: RxStatus.empty());
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if ((hour > 5) && (hour < 12)) {
      return 'Bom dia!';
    } else {
      if (hour > 17 && hour < 5) {
        return 'Boa noite!';
      } else {
        return 'Boa tarde!';
      }
    }
  }

  void setUsername() {}
}
