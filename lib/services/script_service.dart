import 'dart:convert';
import 'dart:io';
import 'package:application/model/attendance_model.dart';
import 'package:application/model/card_model.dart';
import 'package:application/model/element_model.dart';
import 'package:application/util.dart';
import 'package:application/model/script_model.dart';
import 'package:application/services/token_service.dart';
import 'package:http/http.dart' as http;

class ScriptService {
  @override
  void deleteScript({required int id}) {
    // TODO: implement deleteScript
  }

  @override
  Future<List<Scripts>> findAllScripts() async {
    final response = await http.get(Constants.script);
    final List<dynamic> responseMap =
        jsonDecode(utf8.decode(response.bodyBytes));
    return responseMap.map((resp) => Scripts.fromMap(resp)).toList();
  }

  @override
  Future<Scripts> findScript({required int id}) async {
    final response = await http.get(Constants.getScript(id));
    final dynamic responseMap = jsonDecode(utf8.decode(response.bodyBytes));
    return Scripts.fromMap(responseMap);
  }

  @override
  Future<Scripts> postScript({required script}) async {
    final http.Response response = await http.post(
      Constants.setScript,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'token ' + (await TokenService.getToken())!,
      },
      body: script.toJson(),
    );

    if (response.statusCode == 201) {
      return Scripts.fromJson(response.body);
    } else {
      throw Exception('Failed to Create');
    }
  }

  Future<Scripts> updateScript({required Scripts script, required int oldId}) {
    // TODO: implement updateScript
    throw UnimplementedError();
  }

  void attendance({required Cards card, required Elements element}) async {
    Map attendance = {
      'texto': "kiki?",
      'paciente': [1],
      'card': card.id,
      'opcao': element.id,
    };

    final http.Response response = await http.post(
      Constants.setAttendance,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ${await TokenService.getToken()}'
      },
      body: jsonEncode(attendance),
    );

    if (response.statusCode == 201) {
      var i = 1; //debug dos brabos
    } else {
      throw Exception('Failed to create');
    }
  }

  Future<List<Attendance>> getAttendance() async {
    final response = await http.get(Constants.attendance);
    final List<dynamic> responseMap =
        jsonDecode(utf8.decode(response.bodyBytes));
    return responseMap.map((resp) => Attendance.fromMap(resp)).toList();
  }
}
