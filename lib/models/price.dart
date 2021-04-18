import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable(nullable: false)
class Price {
  String code;
  String symbol;
  String rate;
  String description;
  String updated;

  Price({this.code, this.symbol, this.rate, this.description, this.updated});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);

  static Map<String, Price> parseListFromJSON(var jsonList) {
    Map<String, Price> list = Map();
    for (var c in jsonList) {
      final cu = Price.fromJson(c);
      list[cu.code] = cu;
    }
    return list;
  }
}
