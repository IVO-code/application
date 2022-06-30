import 'package:flutter/material.dart';

class Constants {
  String appName = "IVO";

  static const String url = "http://10.0.2.2:8000/api/";
  //static const String url = "http://127.0.0.1:8000/api/";
  static final Uri user = Uri.parse("${url}users");
  static final Uri userPost = Uri.parse("${url}users/");
  static final Uri login = Uri.parse("${url}login/");

  static const Color background = const Color(0xFFF6F6F7);
  static const Color pink = Color.fromARGB(255, 228, 112, 156);
  static const Color orange = const Color(0xFFF29057);
  static const Color green = const Color(0xFF77A158);
  static const Color turquoise = const Color(0xFF33A6A6);
  static const Color purple = const Color(0xFF615481);
  static const Color inactive = const Color(0xFFC4C4C4);
}
