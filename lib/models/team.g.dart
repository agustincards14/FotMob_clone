// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
    json['team_id'] as int,
    json['team_name'] as String,
    json['logo'] as String,
  );
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'team_id': instance.team_id,
      'team_name': instance.team_name,
      'logo': instance.logo,
    };
