import 'dart:convert';

import 'package:application/data/user/datasource/user_remote.dart';
import 'package:application/data/user/user_model.dart';

class Elements {
  int id;
  User? creator;
  String text;
  String figure;
  String video;
  String audio;
  String date;
  int creatorId;
  bool type;
  Elements(
      {required this.id,
      this.creator,
      required this.creatorId,
      required this.text,
      required this.figure,
      required this.video,
      required this.audio,
      required this.date,
      required this.type}) {
    if (creatorId != null) {
      //_findCreator(creatorId);
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'preceptor': creatorId,
      'texto': text,
      'figura': figure,
      'libras': video,
      'audioDescricao': audio,
      'type': type,
    };
  }

  factory Elements.fromMap(Map<String, dynamic> map) {
    return Elements(
        id: map['id'] as int,
        creatorId: map['preceptor'] as int,
        text: map['texto'] as String,
        figure: map['figura'] as String,
        video: map['libras'] as String,
        audio: map['audioDescricao'] as String,
        date: map['data'] as String,
        type: map['tipo'] as bool);
  }

  _findCreator(int id) async {
    try {
      creator = await UserRemote().findUser(id: id);
    } catch (_) {}
  }

  String toJson() => json.encode(toMap());

  factory Elements.fromJson(String source) =>
      Elements.fromMap(json.decode(source) as Map<String, dynamic>);
}
