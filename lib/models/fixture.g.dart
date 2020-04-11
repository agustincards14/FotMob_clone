// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fixture _$FixtureFromJson(Map<String, dynamic> json) {
  return Fixture(
    json['fixture_id'] as int,
    json['league_id'] as int,
    json['event_date'] == null
        ? null
        : DateTime.parse(json['event_date'] as String),
    json['homeTeam'] == null
        ? null
        : Team.fromJson(json['homeTeam'] as Map<String, dynamic>),
    json['awayTeam'] == null
        ? null
        : Team.fromJson(json['awayTeam'] as Map<String, dynamic>),
    json['venue'] as String,
    json['status'] as String,
    (json['score'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    json['event_timestamp'] as int,
  );
}

Map<String, dynamic> _$FixtureToJson(Fixture instance) => <String, dynamic>{
      'fixture_id': instance.id,
      'league_id': instance.league_id,
      'event_date': instance.eventDate?.toIso8601String(),
      'event_timestamp': instance.timestamp,
      'homeTeam': instance.home?.toJson(),
      'awayTeam': instance.away?.toJson(),
      'venue': instance.venue,
      'status': instance.status,
      'score': instance.score,
    };
