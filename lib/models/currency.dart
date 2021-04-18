import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable(nullable: false)
class Currency {
  String currency;
  String country;

  Currency({this.currency, this.country});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  static Map<String, Currency> parseListFromJSON(var jsonList) {
    Map<String, Currency> list = Map();
    for (var c in jsonList) {
      final cu = Currency.fromJson(c);
      list[cu.currency] = cu;
    }
    return list;
  }
}
