import 'dart:convert';

import 'package:application/model/card_model.dart';
import 'package:application/model/element_model.dart';

class Scripts {
  int id;
  Elements? title;
  Elements? description;
  List<Cards?>? cards;
  String date;

  Scripts({
    this.id = 0,
    this.title,
    this.description,
    this.cards,
    this.date = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': title!.id,
      'descricao': description!.id,
      'cards': cards!.map((e) => e!.id).toList(),
    };
  }

  factory Scripts.fromMap(Map<String, dynamic> map) {
    return Scripts(
        id: map['id'] as int,
        title: Elements.fromMap(map['titulo']),
        description: Elements.fromMap(map['descricao']),
        cards: (map['cards'] as List<dynamic>)
            .map((e) => Cards.fromMap(e))
            .toList(),
        date: map['data'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Scripts.fromJson(String source) =>
      Scripts.fromMap(json.decode(source) as Map<String, dynamic>);
}
