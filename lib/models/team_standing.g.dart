// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_standing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamStanding _$TeamStandingFromJson(Map<String, dynamic> json) {
  return TeamStanding(
    json['rank'] as int,
    json['team_id'] as int,
    json['teamName'] as String,
    json['logo'] as String,
    json['forme'] as String,
  )
    ..goalsDiff = json['goalsDiff'] as int
    ..points = json['points'] as int
    ..record = json['all'] == null
        ? null
        : Record.fromJson(json['all'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TeamStandingToJson(TeamStanding instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'team_id': instance.team_id,
      'teamName': instance.teamName,
      'logo': instance.logo,
      'forme': instance.forme,
      'goalsDiff': instance.goalsDiff,
      'points': instance.points,
      'all': instance.record,
    };

Record _$RecordFromJson(Map<String, dynamic> json) {
  return Record(
    json['matchsPlayed'] as int,
    json['win'] as int,
    json['draw'] as int,
    json['lose'] as int,
    json['goalsFor'] as int,
    json['goalsAgainst'] as int,
  );
}

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'matchsPlayed': instance.matchsPlayed,
      'win': instance.win,
      'draw': instance.draw,
      'lose': instance.lose,
      'goalsFor': instance.goalsFor,
      'goalsAgainst': instance.goalsAgainst,
    };
