import 'package:application/data/card/card_model.dart';
import 'package:application/data/token/token_model.dart';

abstract class CardsRepository {
  Future<List<Cards>> findAllCards();
  Future<Cards> findCard({required int id});
  Future<Cards> postCard({required Cards card});
  Future<Cards> updateCard({required Cards card, required int oldId});
  void deleteCard({required int id});
}
