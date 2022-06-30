// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String username;
  String password;
  String occupation;
  String email;
  String firstName;
  String lastName;

  User(
      {required this.username,
      required this.password,
      this.occupation = "unknown",
      this.email = "unknown",
      this.firstName = "unknown",
      this.lastName = "unknown"});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'occupation': occupation,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      password: map['password'] as String,
      occupation: map['occupation'] as String,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
