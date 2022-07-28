import 'dart:math';

import 'package:flutter/material.dart';

class Constants {
  //ROUTES -----------
  static const String url = "https://ivo-acolher-server.herokuapp.com/api/";

  static final Uri user = Uri.parse("${url}preceptores");
  static final Uri element = Uri.parse("${url}elementos");
  static final Uri card = Uri.parse("${url}cards");
  static final Uri script = Uri.parse("${url}roteiros");
  static final Uri attendance = Uri.parse("${url}atendimentos");

  static Uri getUser(int id) => Uri.parse("${url}preceptores/${id}");
  static Uri getElement(int id) => Uri.parse("${url}elementos/${id}");
  static Uri getCard(int id) => Uri.parse("${url}cards/${id}");
  static Uri getScript(int id) => Uri.parse("${url}roteiros/${id}");

  static final Uri setAttendance = Uri.parse("${url}atendimentos/");
  static final Uri setUser = Uri.parse("${url}preceptores/");
  static final Uri setElement = Uri.parse("${url}elementos/");
  static final Uri setCard = Uri.parse("${url}cards/");
  static final Uri setScript = Uri.parse("${url}roteiros/");

  static final Uri login = Uri.parse("${url}login/");

  //COLORS -----------
  static const Color background = const Color(0xFFF6F6F7);
  static const Color black = const Color(0xFF313039);
  static const Color pink = const Color(0xFFE4709F);
  static const Color orange = const Color(0xFFF29057);
  static const Color green = const Color(0xFF77A158);
  static const Color turquoise = const Color(0xFF33A6A6);
  static const Color purple = const Color(0xFF615481);
  static const Color inactive = const Color(0xFFC4C4C4);
  static const Color gray = Color.fromARGB(255, 214, 213, 213);

  static randomColor() {
    var list = [pink, orange, green, turquoise, purple];
    return list[Random().nextInt(list.length)];
  }
}
