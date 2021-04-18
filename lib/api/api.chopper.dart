// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CurrencyTrackerAPI extends CurrencyTrackerAPI {
  _$CurrencyTrackerAPI([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CurrencyTrackerAPI;

  @override
  Future<Response<dynamic>> getSupportedCountries() {
    final $url = 'supported-currencies.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCurrencyUpdates(String currency) {
    final $url = 'currentprice/$currency.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
