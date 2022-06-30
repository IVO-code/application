import 'package:application/data/token/token_model.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:application/data/user/datasource/user_remote.dart';
import 'package:application/data/user/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController with StateMixin {
  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  late UserRepository repository = UserRemote();

  AuthenticationController() {
    change(null, status: RxStatus.loading());
    hasLogin();
  }

  hasLogin() async {
    if (await TokenSecureStorage.hasToken()) {
      change(null, status: RxStatus.empty());
    } else {
      change(null, status: RxStatus.error("token"));
    }
  }

  void login() async {
    var nome = usernameEditingController.text;
    var senha = passwordEditingController.text;
    change(null, status: RxStatus.loading());
    try {
      Token token = await repository.login(
          usernameEditingController.text, passwordEditingController.text);
      TokenSecureStorage.setToken(token);
      change(null, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error("login"));
    }
  }

  void reset() {
    passwordEditingController.clear();
    usernameEditingController.clear();
    change(null, status: RxStatus.error("return"));
  }
}
