import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webapiflutter/screens/dashboard.dart';

void main() {
  
  testWidgets('Should display the main image when dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the transfer feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    Finder transferFeatureItem = _findFeatureWithPredicate('Transfer', Icons.monetization_on);
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets('Should display the transaction feed feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    Finder nameTransactionFeedFeatureItem = _findFeatureWithPredicate('Transaction feed', Icons.description);
    expect(nameTransactionFeedFeatureItem, findsOneWidget);
  });
}

Finder _findFeatureWithPredicate(String name, IconData icon) {
  final transferFeatureItem = find.byWidgetPredicate((Widget widget) {
    if (widget is FeatureItem) {
      return widget.name == name && widget.icon == icon;
    }
    return false;
  });
  return transferFeatureItem;
}
