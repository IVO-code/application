import 'dart:convert';

class Token {
  String token;
  Token({
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) =>
      Token.fromMap(json.decode(source) as Map<String, dynamic>);
}
