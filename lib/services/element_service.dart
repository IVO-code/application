import 'dart:convert';
import 'dart:io';

import 'package:application/util.dart';
import 'package:application/model/element_model.dart';
import 'package:application/model/token_model.dart';
import 'package:application/services/token_service.dart';
import 'package:http/http.dart' as http;

class ElementService {
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
    final http.Response response = await http.post(
      Constants.setElement,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ' + (await TokenService.getToken())!,
      },
      body: await (element.toJson()),
    );

    if (response.statusCode == 201) {
      return Elements.fromJson(utf8.decode(response.bodyBytes));
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
