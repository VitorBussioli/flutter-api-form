import 'package:flutter/material.dart';
import '../service/transacao.dart';
import 'formulario.dart';

class ListaScreen extends StatefulWidget {
  final TransacaoApi transacaoApi = TransacaoApi();

  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  List<Transacao> _transacoes = [];

  void _carregarTransacoes() async {
    List<Transacao> transacoes = await widget.transacaoApi.getAll();
    setState(() {
      _transacoes = transacoes;
    });
  }

  void _deletarTransacao(String id) async {
    await widget.transacaoApi.delete(id);
    _carregarTransacoes();
  }

  void _editarTransacao(Transacao transacao) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioScreen(transacao: transacao),
      ),
    ).then((_) => _carregarTransacoes());
  }

  @override
  void initState() {
    super.initState();
    _carregarTransacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Transações')),
      body: ListView.builder(
        itemCount: _transacoes.length,
        itemBuilder: (context, index) {
          final transacao = _transacoes[index];
          return ListTile(
            title: Text(transacao.descricao),
            subtitle: Text('R\$ ${transacao.valor.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editarTransacao(transacao),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deletarTransacao(transacao.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioScreen()),
          ).then((_) => _carregarTransacoes());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
