import 'package:flutter/material.dart';
import 'package:webapiflutter/database/dao/contact_dao.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(BytebankApp(contactDao: ContactDao()));
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;

  const BytebankApp({@required this.contactDao});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )),
      home: Dashboard(contactDao: contactDao),
    );
  }
}
