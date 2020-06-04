import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webapiflutter/screens/dashboard.dart';

import '../matchers.dart';
import '../mocks.dart';

void main() {

  final mockContactDao = MockContactDao();
  
  testWidgets('Should display the main image when dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the transfer feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
    Finder transferFeatureItem = findFeatureWithPredicate('Transfer', Icons.monetization_on);
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets('Should display the transaction feed feature when the Dashboard is opened', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
    Finder nameTransactionFeedFeatureItem = findFeatureWithPredicate('Transaction feed', Icons.description);
    expect(nameTransactionFeedFeatureItem, findsOneWidget);
  });
}

