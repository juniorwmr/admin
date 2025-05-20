import 'package:flutter/material.dart';

class MenuAppController {
  static final MenuAppController _instance = MenuAppController._internal();

  factory MenuAppController() {
    return _instance;
  }

  MenuAppController._internal();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<bool> _isMenuOpen = ValueNotifier<bool>(false);

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  ValueNotifier<bool> get isMenuOpen => _isMenuOpen;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
      _isMenuOpen.value = true;
    } else {
      _scaffoldKey.currentState!.closeDrawer();
      _isMenuOpen.value = false;
    }
  }
}
