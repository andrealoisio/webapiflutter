import 'package:flutter/material.dart';

class TransactionsAuthDialog extends StatefulWidget {

  final Function(String password) onConfirm;

  const TransactionsAuthDialog({@required this.onConfirm});

  @override
  _TransactionsAuthDialogState createState() => _TransactionsAuthDialogState();
}

class _TransactionsAuthDialogState extends State<TransactionsAuthDialog> {

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        autofocus: true,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          fontSize: 32,
          letterSpacing: 24,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
