import 'dart:io';

import 'package:application/model/attendance_model.dart';
import 'package:application/services/script_service.dart';
import 'package:application/util.dart';
import 'package:application/model/token_model.dart';
import 'package:application/services/token_service.dart';
import 'package:application/services/user_service.dart';
import 'package:application/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with StateMixin {
  late UserService repository = UserService();

  static const _storage = FlutterSecureStorage();
  Color color = Colors.black;
  RxString redirect = "5...".obs;

  RxList<Attendance> attendances = RxList<Attendance>();

  ProfileController() {
    change(null, status: RxStatus.loading());
    loadUser();
    loadColor();
    loadAttendances();
  }

  Future<bool> hasLogin() async {
    return await TokenService.hasToken();
  }

  void loadUser() async {
    change(null, status: RxStatus.loading());

    if (await hasLogin()) {
      try {
        String? id = await TokenService.getId();
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
    TokenService.invalidate();
    Get.back(result: "logout", closeOverlays: true);
  }

  void loadAttendances() async {
    attendances.clear();
    try {
      attendances.addAll(await (ScriptService().getAttendance()));
    } catch (e) {
      var i = 1;
    }
  }
}
