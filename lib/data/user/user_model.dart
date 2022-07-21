import 'dart:convert';

class User {
  String username;
  String occupation;
  String email;
  String firstName;
  String lastName;

  User({
    required this.username,
    required this.occupation,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'occupation': occupation,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      occupation: map['ocupacao'] as String,
      email: map['email'] as String,
      firstName: map['username'] as String,
      lastName: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
