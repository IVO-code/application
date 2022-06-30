import 'package:application/data/token/token_model.dart';
import 'package:application/data/user/user_model.dart';

abstract class UserRepository {
  Future<List<User>> findAllUsers();
  Future<User> findUser({required int id});
  Future<User> postUser({required User user});
  Future<User> updateUser({required User user, required int oldId});
  Future<Token> login(String username, String password);
  void deleteUser({required int id});
}
