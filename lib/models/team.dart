import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Team {
  @JsonKey()
  final int team_id;
  @JsonKey()
  final String team_name;
  // @JsonKey()
  // final String venue_name;
  @JsonKey()
  final String logo;
  // @JsonKey()
  // final String country;

  Team(this.team_id, this.team_name, this.logo);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
