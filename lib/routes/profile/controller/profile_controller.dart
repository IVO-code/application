import 'dart:io';

import 'package:application/assets/constants.dart';
import 'package:application/data/token/token_model.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:application/data/user/datasource/user_remote.dart';
import 'package:application/data/user/user_model.dart';
import 'package:application/data/user/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with StateMixin {
  late UserRepository repository = UserRemote();

  static const _storage = FlutterSecureStorage();
  Color color = Colors.black;
  RxString redirect = "5...".obs;

  ProfileController() {
    change(null, status: RxStatus.loading());
    loadUser();
    loadColor();
  }

  Future<bool> hasLogin() async {
    return await TokenSecureStorage.hasToken();
  }

  void loadUser() async {
    change(null, status: RxStatus.loading());

    if (await hasLogin()) {
      try {
        String? id = await TokenSecureStorage.getId();
        if (id != null) {
          User user = await repository.findUser(id: int.parse(id));
          if (user != null) {
            change(user, status: RxStatus.success());
          } else {
            errorRedirect();
          }
        }
      } catch (error) {
        errorRedirect();
      }
    } else {
      errorRedirect();
    }
  }

  errorRedirect() async {
    change(null, status: RxStatus.error());
    await Future.delayed(Duration(seconds: 1));
    redirect.value = "4...";
    await Future.delayed(Duration(seconds: 1));
    redirect.value = "3...";
    await Future.delayed(Duration(seconds: 1));
    redirect.value = "2...";
    await Future.delayed(Duration(seconds: 1));
    redirect.value = "1...";
    await Future.delayed(Duration(seconds: 1));
    logout();
  }

  void setColor(String arg) {
    if (arg != "") {
      _storage.write(key: "color", value: arg);
      color = Color(int.parse(arg, radix: 16));
    }
    loadColor();
  }

  void loadColor() async {
    String? arg = await _storage.read(key: "color");
    if (arg != null) {
      color = Color(int.parse(arg, radix: 16));
    } else {
      color = Constants.green;
    }
  }

  void logout() {
    TokenSecureStorage.invalidate();
    Get.back(result: "logout", closeOverlays: true);
  }
}
