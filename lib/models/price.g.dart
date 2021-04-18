// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) {
  return Price(
    code: json['code'] as String,
    symbol: json['symbol'] as String,
    rate: json['rate'] as String,
    description: json['description'] as String,
    updated: json['updated'] as String,
  );
}

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'code': instance.code,
      'symbol': instance.symbol,
      'rate': instance.rate,
      'description': instance.description,
      'updated': instance.updated,
    };
