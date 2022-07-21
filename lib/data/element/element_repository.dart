import 'package:application/data/element/element_model.dart';
import 'package:application/data/token/token_model.dart';

abstract class ElementRepository {
  Future<List<Elements>> findAllElements();
  Future<Elements> findElement({required int id});
  Future<Elements> postElement({required Elements element});
  Future<Elements> updateElement(
      {required Elements element, required int oldId});
  void deleteElement({required int id});
}
