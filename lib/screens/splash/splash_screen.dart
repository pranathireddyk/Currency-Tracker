import 'package:currency_tracker/screens/pick_currency/pick_currency.dart';
import 'package:currency_tracker/screens/tabs_page/tabs_screen.dart';
import 'package:currency_tracker/services/currencies.dart';
import 'package:currency_tracker/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../services/shared_preferences.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  bool _checkedForData = false;

  Future<void> checkForLocalData(BuildContext context) async {
    if (!_checkedForData) {
      _checkedForData = true;
      final selectedCurrencies =
          await GetIt.I<SharedPrefStateBloc>().readSelectedCurrencies();
      print(selectedCurrencies.length);
      if (selectedCurrencies.length > 1) {
        Provider.of<CurrenciesService>(context, listen: false)
            .createEmptyPrices(selectedCurrencies);
        Navigator.of(context)
            .pushReplacement(AppNavigation.route(TabsScreen()));
        return;
      }

      Navigator.of(context)
          .pushReplacement(AppNavigation.route(PickCurrency()));
    }
  }

  @override
  Widget build(BuildContext context) {
    checkForLocalData(context);
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 128.0,
        ),
      ),
    );
  }
}
