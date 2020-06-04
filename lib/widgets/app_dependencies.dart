import 'package:flutter/material.dart';
import 'package:webapiflutter/database/dao/contact_dao.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;

  AppDependencies({
    @required this.contactDao,
    @required Widget child,
  }) : super(child: child);

  static AppDependencies of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao;
  }
}
