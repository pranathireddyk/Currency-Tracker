import 'package:currency_tracker/screens/pick_currency/pick_currency_controller.dart';
import 'package:currency_tracker/screens/splash/splash_screen.dart';
import 'package:currency_tracker/services/currencies.dart';
import 'package:currency_tracker/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  setupServices();
  runApp(CurrencyTracker());
}

void setupServices() {
  GetIt.I.registerSingleton(SharedPrefStateBloc());
  GetIt.I.registerSingleton(CurrenciesService());
}

class CurrencyTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CurrenciesService(),
        ),
        ChangeNotifierProvider(
          create: (_) => PickCurrencyController(),
        ),
      ],
      child: MaterialApp(
        title: 'Currency Tracker',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
