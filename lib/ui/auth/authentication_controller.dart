import 'package:application/util.dart';
import 'package:application/model/token_model.dart';
import 'package:application/services/token_service.dart';
import 'package:application/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final RxInt index = 0.obs;

  AuthenticationController() {
    hasLogin();
  }

  hasLogin() async {
    if (await TokenService.hasToken()) {
      Get.back(result: "logged");
    }
  }
}
