import 'package:flutter/material.dart';
import 'package:persistenciaflutter/http/webclient.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(BytebankApp());
  findAll().then((value) {
    print('novastransacoes: $value');
  });
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary)),
      home: Dashboard(),
    );
  }
}
