import 'dart:convert';
import 'dart:io';
import 'package:application/assets/constants.dart';
import 'package:application/data/Card/Card_repository.dart';
import 'package:application/data/card/card_model.dart';
import 'package:application/data/token/token_model.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:http/http.dart' as http;

class CardRemote implements CardsRepository {
  @override
  void deleteCard({required int id}) {
    // TODO: implement deleteCard
  }

  @override
  Future<List<Cards>> findAllCards() async {
    final response = await http.get(Constants.card);
    final List<dynamic> responseMap =
        jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    return responseMap.map((resp) => Cards.fromMap(resp)).toList();
  }

  @override
  Future<Cards> findCard({required int id}) async {
    final response = await http.get(Constants.getCard(id));
    final dynamic responseMap = jsonDecode(response.body);
    return Cards.fromMap(responseMap);
  }

  @override
  Future<Cards> postCard({required card}) async {
    Map el = {
      'preceptor': card.creatorId,
      'texto': card.text,
      'figura': card.figure,
      'libras': card.video,
      'audioDescricao': card.audio,
      'tipo': card.type,
    };

    final http.Response response = await http.post(
      Constants.setCard,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'token ' + (await TokenSecureStorage.getToken())!,
      },
      body: jsonEncode(el),
    );

    if (response.statusCode == 201) {
      return Cards.fromJson(response.body);
    } else {
      throw Exception('Failed to Create');
    }
  }

  @override
  Future updateCard({required card, required int oldId}) {
    // TODO: implement updateCard
    throw UnimplementedError();
  }
}
