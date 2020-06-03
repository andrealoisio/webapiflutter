import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webapiflutter/screens/dashboard.dart';

Finder findFeatureWithPredicate(String name, IconData icon) {
  final transferFeatureItem = find.byWidgetPredicate((Widget widget) {
    if (widget is FeatureItem) {
      return widget.name == name && widget.icon == icon;
    }
    return false;
  });
  return transferFeatureItem;
}