import 'dart:convert';

import 'package:application/data/user/datasource/user_remote.dart';
import 'package:application/data/user/user_model.dart';

class Cards {
  int id;
  User? creator;
  String text;
  String figure;
  String video;
  String audio;
  String date;
  int creatorId;
  bool type;
  Cards(
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

  factory Cards.fromMap(Map<String, dynamic> map) {
    return Cards(
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

  factory Cards.fromJson(String source) =>
      Cards.fromMap(json.decode(source) as Map<String, dynamic>);
}
