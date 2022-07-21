import 'dart:convert';
import 'dart:io';

import 'package:application/assets/constants.dart';
import 'package:application/data/element/element_model.dart';
import 'package:application/data/element/element_repository.dart';
import 'package:application/data/token/token_model.dart';
import 'package:application/data/token/token_secure_storage.dart';
import 'package:http/http.dart' as http;

class ElementRemote implements ElementRepository {
  @override
  void deleteElement({required int id}) {
    // TODO: implement deleteElement
  }

  @override
  Future<List<Elements>> findAllElements() async {
    final response = await http.get(Constants.element);
    final List<dynamic> responseMap =
        jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    return responseMap.map((resp) => Elements.fromMap(resp)).toList();
  }

  @override
  Future<Elements> findElement({required int id}) async {
    final response = await http.get(Constants.getElement(id));
    final dynamic responseMap = jsonDecode(response.body);
    return Elements.fromMap(responseMap);
  }

  @override
  Future<Elements> postElement({required Elements element}) async {
    Map el = {
      'preceptor': element.creatorId,
      'texto': element.text,
      'figura': element.figure,
      'libras': element.video,
      'audioDescricao': element.audio,
      'tipo': element.type,
    };

    final http.Response response = await http.post(
      Constants.setElement,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'token ' + (await TokenSecureStorage.getToken())!,
      },
      body: jsonEncode(el),
    );

    if (response.statusCode == 201) {
      return Elements.fromJson(response.body);
    } else {
      throw Exception('Failed to Create');
    }
  }

  @override
  Future<Elements> updateElement(
      {required Elements element, required int oldId}) {
    // TODO: implement updateElement
    throw UnimplementedError();
  }
}
