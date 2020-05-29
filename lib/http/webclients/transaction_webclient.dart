import 'dart:convert';

import 'package:http/http.dart';
import 'package:persistenciaflutter/model/transaction.dart';
import 'package:webapiflutter/model/contact.dart';
import 'package:webapiflutter/model/transaction.dart';

import '../webclient.dart';

class TransactionWebClient {
  
  final String baseUrl = 'http://192.168.100.7:8080/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    return _toTransactions(response);
  }

  Future<Transaction> save(Transaction transaction) async {

    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson,
    );

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }

}
