import 'package:flutter/material.dart';
import '../service/transacao.dart';

class FormularioScreen extends StatefulWidget {
  final Transacao? transacao;
  final TransacaoApi transacaoApi = TransacaoApi();

  FormularioScreen({this.transacao});

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.transacao != null) {
      _descricaoController.text = widget.transacao!.descricao;
      _valorController.text = widget.transacao!.valor.toString();
    }
  }

  void _salvarTransacao() async {
    String descricao = _descricaoController.text;
    double valor = double.parse(_valorController.text);

    if (widget.transacao == null) {
      Transacao novaTransacao =
          Transacao(id: "", descricao: descricao, valor: valor);
      await widget.transacaoApi.create(novaTransacao);
    } else {
      Transacao transacaoEditada = Transacao(
        id: widget.transacao!.id,
        descricao: descricao,
        valor: valor,
      );
      await widget.transacaoApi.update(transacaoEditada.id, transacaoEditada);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.transacao == null ? 'Nova Transação' : 'Editar Transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarTransacao,
              child: Text(widget.transacao == null ? 'Adicionar' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
