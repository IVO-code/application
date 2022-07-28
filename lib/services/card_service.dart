import 'dart:convert';
import 'dart:io';
import 'package:application/util.dart';
import 'package:application/model/card_model.dart';
import 'package:application/model/token_model.dart';
import 'package:application/services/token_service.dart';
import 'package:http/http.dart' as http;

class CardService {
  void deleteCard({required int id}) {
    // TODO: implement deleteCard
  }

  Future<List<Cards>> findAllCards() async {
    final response = await http.get(Constants.card);
    final List<dynamic> responseMap =
        jsonDecode(utf8.decode(response.bodyBytes));
    return responseMap.map((resp) => Cards.fromMap(resp)).toList();
  }

  Future<Cards> findCard({required int id}) async {
    final response = await http.get(Constants.getCard(id));
    final dynamic responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    return Cards.fromMap(responseMap);
  }

  Future<Cards> postCard({required card}) async {
    final http.Response response = await http.post(
      Constants.setCard,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'token ' + (await TokenService.getToken())!,
      },
      body: card.toJson(),
    );

    if (response.statusCode == 201) {
      return Cards.fromJson(response.body);
    } else {
      throw Exception('Failed to Create');
    }
  }

  @override
  Future<Cards> updateCard({required Cards card, required int oldId}) {
    // TODO: implement updateCard
    throw UnimplementedError();
  }
}
