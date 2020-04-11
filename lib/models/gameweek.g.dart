// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameweek.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gameweek _$GameweekFromJson(Map<String, dynamic> json) {
  return Gameweek(
    json['results'] as int,
    (json['fixtures'] as List)
        ?.map((e) =>
            e == null ? null : Fixture.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GameweekToJson(Gameweek instance) => <String, dynamic>{
      'fixtures': instance.fixtures,
      'results': instance.results,
    };
