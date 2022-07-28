import 'dart:convert';

import 'package:application/services/token_service.dart';
import 'package:application/services/user_service.dart';
import 'package:application/model/user_model.dart';

class Elements {
  int id;
  String text;
  String figure;
  String video;
  String audio;
  String date;
  bool type;

  Elements(
      {this.id = 0,
      this.text = '',
      this.figure = '',
      this.video = '',
      this.audio = '',
      this.date = '',
      this.type = false});

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      'preceptor': await TokenService.getId(),
      'texto': text,
      'figura': figure,
      'libras': video,
      'audioDescricao': audio,
      'tipo': type,
    };
  }

  factory Elements.fromMap(Map<String, dynamic> map) {
    return Elements(
        id: map['id'] as int,
        text: map['texto'] as String,
        figure: map['figura'] as String,
        video: map['libras'] as String,
        audio: map['audioDescricao'] as String,
        date: map['data'] as String,
        type: map['tipo'] as bool);
  }

  Future<String> toJson() async => json.encode(await toMap());

  factory Elements.fromJson(String source) =>
      Elements.fromMap(json.decode(source) as Map<String, dynamic>);
}
