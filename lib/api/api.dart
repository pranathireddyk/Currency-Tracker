import 'package:chopper/chopper.dart';
import 'package:currency_tracker/api/urls.dart';

part 'api.chopper.dart';

@ChopperApi()
abstract class CurrencyTrackerAPI extends ChopperService {
  @Get(path: Urls.SUPPORTED)
  Future<Response> getSupportedCountries();

  @Get(path: Urls.CURRENT_PRICE + "/{currency}.json")
  Future<Response> getCurrencyUpdates(@Path() String currency);

  static CurrencyTrackerAPI create() {
    final client = ChopperClient(
      baseUrl: Urls.BASE_URL,
      services: [
        _$CurrencyTrackerAPI(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );
    return _$CurrencyTrackerAPI(client);
  }
}
