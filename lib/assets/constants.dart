import 'package:flutter/material.dart';

class Constants {
  String appName = "IVO";

  static const String url = "https://ivo-server-test.herokuapp.com/api/";
  //static const String url = "http://127.0.0.1:8000/api/";
  static final Uri user = Uri.parse("${url}preceptores");
  static Uri getUser(int id) => Uri.parse("${url}preceptores/${id}");
  static final Uri setUser = Uri.parse("${url}preceptores/");
  static final Uri login = Uri.parse("${url}login/");

  static const Color background = const Color(0xFFF6F6F7);
  static const Color black = const Color(0xFF313039);
  static const Color pink = Color.fromARGB(255, 228, 112, 156);
  static const Color orange = const Color(0xFFF29057);
  static const Color green = const Color(0xFF77A158);
  static const Color turquoise = const Color(0xFF33A6A6);
  static const Color purple = const Color(0xFF615481);
  static const Color inactive = const Color(0xFFC4C4C4);
  static const Color gray = Color.fromARGB(255, 214, 213, 213);
}
