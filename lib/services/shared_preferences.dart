import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const CURRENCIES = "currencies";

class SharedPrefStateBloc {
  final secureStorage = FlutterSecureStorage();

  Future<List<String>> readSelectedCurrencies() async {
    final currencies = await secureStorage.read(key: CURRENCIES) ?? "";
    return currencies.split(",");
  }

  Future<void> storeSelectedCurrencies(List<String> currencies) async {
    await secureStorage.write(key: CURRENCIES, value: currencies.join(","));
  }

  Future<void> clear() async {
    await secureStorage.deleteAll();
  }
}
