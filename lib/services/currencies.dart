import 'package:currency_tracker/models/currency.dart';
import 'package:currency_tracker/models/price.dart';
import 'package:currency_tracker/services/api.dart';
import 'package:currency_tracker/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

enum Status { Idle, Loading, Loaded, Error }

class CurrenciesService extends ChangeNotifier {
  Map<String, Currency> _currencies = Map();
  Map<String, Price> _selectedCurrencies = Map();

  void createEmptyPrices(List<String> currencies){
    _currencies.forEach((key, value) {
      _selectedCurrencies[key] = Price();
    });
  }

  Future<void> fetchCurrencies() async {
    final response = await APIService.api.getSupportedCountries();
    if (response.isSuccessful) {
      _currencies = await compute(Currency.parseListFromJSON, response.body);
      print(_currencies.length);
      return _currencies;
    } else {
      print("Unable to load currencies");
      return null;
    }
  }

  void selectOrDeselectCurrency(Currency currency) {
    if (_selectedCurrencies.containsKey(currency.currency)) {
      _selectedCurrencies.remove(currency.currency);
    } else {
      _selectedCurrencies[currency.currency] = Price(code: currency.currency);
    }
    notifyListeners();
  }

  Map<String, Price> get selectedCurrencies => _selectedCurrencies;

  set selectedCurrencies(Map<String, Price> value) {
    _selectedCurrencies = value;
    notifyListeners();
  }

  Map<String, Currency> get currencies => _currencies;

  set currencies(Map<String, Currency> value) {
    _currencies = value;
    notifyListeners();
  }

  void refresh() {
    selectedCurrencies.forEach((key, v) {
      APIService.api.getCurrencyUpdates(key).then((response) {
        // print(response.body["bpi"]);
        var p = Price.fromJson(response.body["bpi"][key]);
        p.updated = response.body["time"]["updated"];
        selectedCurrencies.update(key, (value) => p);
        notifyListeners();
      });
    });
  }

  int saveLocally() {
    if (selectedCurrencies.keys.length > 0) {
      List<String> selected = selectedCurrencies.keys.toList();
      GetIt.I<SharedPrefStateBloc>().storeSelectedCurrencies(selected);
      return 0;
    }
    return -1;
  }
}
