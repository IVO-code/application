import 'dart:convert';

import 'package:application/assets/constants.dart';
import 'package:application/data/token/token_model.dart';
import 'package:application/data/user/user_model.dart';
import 'package:application/data/user/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRemote implements UserRepository {
  @override
  void deleteUser({required int id}) {
    // TODO: implement deleteUser
  }

  @override
  Future<List<User>> findAllUsers() async {
    final response = await http.get(Constants.user);
    final List<dynamic> responseMap = jsonDecode(response.body);
    return responseMap.map((resp) => User.fromMap(resp)).toList();
  }

  @override
  Future<User> findUser({required int id}) {
    // TODO: implement findUser
    throw UnimplementedError();
  }

  @override
  Future<User> postUser({required User user}) {
    // TODO: implement postUser
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser({required User user, required int oldId}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Token> login(String username, String password) async {
    Map login = {
      'usuario': username,
      'senha': password,
      'email': "",
    };

    final http.Response response = await http.post(
      Constants.login,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(login),
    );

    if (response.statusCode == 202) {
      return Token.fromJson(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
