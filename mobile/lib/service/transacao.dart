import 'dart:convert';
import 'package:http/http.dart' as http;
import 'abstract_api.dart';

class Transacao {
  String id;
  String descricao;
  double valor;

  Transacao({required this.id, required this.descricao, required this.valor});

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
      'valor': valor,
    };
  }
}

class TransacaoApi extends AbstractApi<Transacao> {
  TransacaoApi() : super('transacoes');

  @override
  Transacao fromJson(Map<String, dynamic> json) {
    return Transacao.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Transacao data) {
    return data.toJson();
  }
}
