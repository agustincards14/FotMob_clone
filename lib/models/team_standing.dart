import 'package:json_annotation/json_annotation.dart';

part 'team_standing.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TeamStanding {
  @JsonKey()
  final int rank;
  @JsonKey()
  final int team_id;
  @JsonKey()
  final String teamName;
  @JsonKey()
  final String logo;
  @JsonKey()
  String forme;
  @JsonKey()
  int goalsDiff;
  @JsonKey()
  int points;
  @JsonKey(name: "all")
  Record record;

  TeamStanding(this.rank, this.team_id, this.teamName, this.logo, this.forme);

  factory TeamStanding.fromJson(Map<String, dynamic> json) =>
      _$TeamStandingFromJson(json);

  @override
  String toString() => "(${rank}) - $teamName __${forme}__\n";
}

@JsonSerializable(ignoreUnannotated: true)
class Record {
  @JsonKey()
  int matchsPlayed;
  @JsonKey()
  int win;
  @JsonKey()
  int draw;
  @JsonKey()
  int lose;
  @JsonKey()
  int goalsFor;
  @JsonKey()
  int goalsAgainst;

  Record(this.matchsPlayed, this.win, this.draw, this.lose, this.goalsFor,
      this.goalsAgainst);

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
