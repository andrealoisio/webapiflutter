import 'package:flutter/material.dart';
import 'package:webapiflutter/components/centered_messages.dart';
import 'package:webapiflutter/components/progress.dart';
import 'package:webapiflutter/model/transaction.dart';
import 'package:webapiflutter/widgets/app_dependencies.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder(
          future:
              Future.delayed(Duration(seconds: 1)).then((value) => dependencies.transactionWebClient.findAll()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction> transactions = snapshot.data;
                  if (transactions.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transaction.contact.name + ' => ' + transaction.value.toString(),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    );
                  }
                }
                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );
                break;
            }
            return CenteredMessage('Unknown error');
          }),
    );
  }
}
