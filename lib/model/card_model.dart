import 'dart:convert';

import 'package:application/model/element_model.dart';

class Cards {
  int id;
  Elements? title;
  Elements? description;
  List<Elements?>? options;
  String date;

  Cards({
    this.id = 0,
    this.title,
    this.description,
    this.options,
    this.date = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': title!.id,
      'descricao': description!.id,
      'opcoes': options!.map((e) => e!.id).toList(),
    };
  }

  factory Cards.fromMap(Map<String, dynamic> map) {
    return Cards(
        id: map['id'] as int,
        title: Elements.fromMap(map['titulo']),
        description: Elements.fromMap(map['descricao']),
        options: map['opcoes'] == null
            ? null
            : (map['opcoes'] as List<dynamic>)
                .map((e) => Elements.fromMap(e))
                .toList(),
        date: map['data'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Cards.fromJson(String source) =>
      Cards.fromMap(json.decode(source) as Map<String, dynamic>);
}
