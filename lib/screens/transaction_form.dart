import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:webapiflutter/components/progress.dart';
import 'package:webapiflutter/http/webclients/transaction_webclient.dart';
import 'package:webapiflutter/model/contact.dart';
import 'package:webapiflutter/model/transaction.dart';
import 'package:webapiflutter/screens/response_dialog.dart';
import 'package:webapiflutter/screens/transactions_auth_dialog.dart';
import 'package:webapiflutter/widgets/app_dependencies.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    print('Transaction form id $transactionId');
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(
                    message: 'Sending...',
                  ),
                ),
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  autofocus: true,
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value = double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(transactionId, value, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) => TransactionsAuthDialog(
                                onConfirm: (String password) {
                                  _save(dependencies.transactionWebClient, transactionCreated, password, context);
                                },
                              ));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(TransactionWebClient transactionWebClient, Transaction transactionCreated, String password, BuildContext context) async {
    Transaction transaction = await _send(
      transactionWebClient,
      transactionCreated,
      password,
      context,
    );

    _showSuccessFulMessage(
      transaction,
      context,
    );
  }

  Future _showSuccessFulMessage(Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Successful transaction');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(TransactionWebClient transactionWebClient, Transaction transactionCreated, String password, BuildContext context) async {
    setState(() {
      _sending = true;
    });
    await Future.delayed(Duration(seconds: 1));
    final Transaction transaction = await transactionWebClient.save(transactionCreated, password).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError(
      (e) {
        _showFailureMessage(context, message: 'Timeout');
      },
      test: (e) => e is TimeoutException,
    ).catchError((e) {
      _showFailureMessage(context);
    }).whenComplete(() => {
          setState(() {
            _sending = false;
          })
        });
    return transaction;
  }

  void _showFailureMessage(BuildContext context, {String message = 'Unknown error'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
