import 'package:flutter/material.dart';

class MenuAppController {
  final ValueNotifier<GlobalKey<ScaffoldState>> _scaffoldKey = ValueNotifier(
    GlobalKey<ScaffoldState>(),
  );

  ValueNotifier<GlobalKey<ScaffoldState>> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.value.currentState!.isDrawerOpen) {
      _scaffoldKey.value.currentState!.openDrawer();
    }
  }
}
