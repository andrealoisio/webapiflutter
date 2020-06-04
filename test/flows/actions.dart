import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers.dart';

Future<void> clickOnTransferFeatureItem(WidgetTester tester) async {
  final transferFeatureItem = findFeatureWithPredicate('Transfer', Icons.monetization_on);
  expect(transferFeatureItem, findsOneWidget);
  return tester.tap(transferFeatureItem);
}