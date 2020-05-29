import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapiflutter/model/transaction.dart';

import '../webclient.dart';

class TransactionWebClient {
  final String baseUrl = 'http://192.168.100.7:8080/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
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

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
