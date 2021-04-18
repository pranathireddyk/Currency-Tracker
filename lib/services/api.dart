import 'package:currency_tracker/api/api.dart';

class APIService {
  static final CurrencyTrackerAPI api = CurrencyTrackerAPI.create();
  static int refreshTime = 10;
}
