import 'dart:convert';

class User {
  String username;
  String occupation;
  String email;
  String firstName;
  String lastName;

  User({
    this.username = '',
    this.occupation = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
  });

  String fullName() => '$firstName $lastName';

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
      username: map['username'] ?? '',
      occupation: map['ocupacao'] ?? '',
      email: map['email'] ?? '',
      firstName: map['username'] ?? '',
      lastName: map['username'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
