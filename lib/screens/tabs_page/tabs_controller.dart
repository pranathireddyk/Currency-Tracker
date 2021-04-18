import 'package:currency_tracker/screens/settings_page/settings_screen.dart';
import 'package:currency_tracker/screens/tracking_page/tracking_screen.dart';
import 'package:flutter/cupertino.dart';

class TabsController extends ChangeNotifier {
  int _currentScreen = 0;

  final screens = <Widget>[TrackingScreen(), SettingsScreen()];

  int get currentScreen => _currentScreen;

  set currentScreen(int value) {
    _currentScreen = value;
    notifyListeners();
  }
}
