import 'package:application/assets/constants.dart';
import 'package:application/data/token/token_model.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:application/data/user/datasource/user_remote.dart';
import 'package:application/data/user/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final RxInt index = 0.obs;

  AuthenticationController() {
    hasLogin();
  }

  hasLogin() async {
    if (await TokenSecureStorage.hasToken()) {
      Get.back(result: "logged");
    }
  }
}
