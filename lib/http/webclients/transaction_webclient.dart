import 'dart:convert';

import 'package:http/http.dart';
import 'package:webapiflutter/model/transaction.dart';

import '../webclient.dart';

class TransactionWebClient {
  final String baseUrl = 'http://192.168.100.7:8080/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);

  }

  static final Map<int, String> _statusCodeResponses =  {
    400: 'There was an error submitting the transaction',
    401: 'Authentication failed',
  };

}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}