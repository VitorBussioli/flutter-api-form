import "package:http/http.dart" as http;
import 'dart:convert';

abstract class AbstractApi<T> {
  final _urlLocalHost = 'http://localhost:3000';
  String _recurso;

  AbstractApi(this._recurso);

  Future<List<T>> getAll() async {
    var response = await http.get(Uri.parse('$_urlLocalHost/$_recurso'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => fromJson(data)).toList();
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  }

  Future<T> create(T data) async {
    var response = await http.post(
      Uri.parse('$_urlLocalHost/$_recurso'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(toJson(data)),
    );
    if (response.statusCode == 201) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao criar o registro');
    }
  }

  Future<void> update(String id, T data) async {
    var response = await http.put(
      Uri.parse('$_urlLocalHost/$_recurso/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(toJson(data)),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar o registro');
    }
  }

  Future<void> delete(String id) async {
    var response = await http.delete(Uri.parse('$_urlLocalHost/$_recurso/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar o registro');
    }
  }

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T data);
}
