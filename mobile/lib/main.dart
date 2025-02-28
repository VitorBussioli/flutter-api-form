import 'package:flutter/material.dart';
import 'screen/formulario.dart';
import 'screen/lista.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaScreen(),
    );
  }
}
