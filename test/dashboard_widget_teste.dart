import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webapiflutter/screens/dashboard.dart';

import 'matchers.dart';

void main() {
  
  testWidgets('Should display the main image when dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the transfer feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    Finder transferFeatureItem = findFeatureWithPredicate('Transfer', Icons.monetization_on);
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets('Should display the transaction feed feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    Finder nameTransactionFeedFeatureItem = findFeatureWithPredicate('Transaction feed', Icons.description);
    expect(nameTransactionFeedFeatureItem, findsOneWidget);
  });
}

