import 'dart:convert';
import 'package:treino/model/model_tratores.dart';
import 'package:http/http.dart' as http;

Future<List<Tratores>> fetchTratoress() async {
  final response = await http.get(Uri.parse('https://servicodados.ibge.gov.br/api/v2/censos/nomes/')); // URL da sua API

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Tratores.fromJson(json)).toList();
  } else {
    throw Exception('Falha ao carregar Tratoress');
  }
}