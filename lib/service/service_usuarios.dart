
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treino/model/model_usuarios.dart';



Future<List<Usuarios>> fetchUsuarios() async {
  final response = await http.get(Uri.parse('https://servicodados.ibge.gov.br/api/v2/censos/nomes/')); // URL da sua API

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Usuarios.fromJson(json)).toList();
  } else {
    throw Exception('Falha ao carregar Usuarios');
  }
}
