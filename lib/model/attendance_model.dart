import 'dart:convert';

import 'package:application/model/card_model.dart';
import 'package:application/model/element_model.dart';

class Attendance {
  int id;
  Elements? option;
  Cards? card;

  Attendance({
    this.id = 0,
    this.option,
    this.card,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'] as int,
      option: Elements.fromMap(map['opcao']),
      card: Cards.fromMap(map['card']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);
}
