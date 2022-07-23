import 'dart:convert';

import 'package:application/data/user/datasource/user_remote.dart';
import 'package:application/data/user/user_model.dart';

class Cards {
  int id;
  int title;
  int description;
  List<int> options;
  String date;

  Cards({
    required this.id,
    required this.title,
    required this.description,
    required this.options,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': title,
      'descricao': description,
      'opcoes': options,
    };
  }

  factory Cards.fromMap(Map<String, dynamic> map) {
    return Cards(
        id: map['id'] as int,
        title: map['titulo'] as int,
        description: map['descricao'] as int,
        options: (map['opcoes'] as List<dynamic>).map((e) => e as int).toList(),
        date: map['data'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Cards.fromJson(String source) =>
      Cards.fromMap(json.decode(source) as Map<String, dynamic>);
}
