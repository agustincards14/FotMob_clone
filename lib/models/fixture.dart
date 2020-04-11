import 'package:json_annotation/json_annotation.dart';
import 'package:fotmob_clone/models/team.dart';
import 'package:fotmob_clone/models/league.dart';

part 'fixture.g.dart';

@JsonSerializable(ignoreUnannotated: true, explicitToJson: true)
class Fixture {
  @JsonKey(name: 'fixture_id')
  final int id;
  String leagueName;
  @JsonKey(name: 'league_id')
  final int league_id;
  League league;
  @JsonKey(name: 'event_date')
  final DateTime eventDate;
  @JsonKey(name: "event_timestamp")
  final int timestamp;
  @JsonKey(name: "homeTeam")
  final Team home;
  @JsonKey(name: "awayTeam")
  final Team away;
  @JsonKey()
  final String venue;
  @JsonKey()
  final String status;
  @JsonKey()
  final Map<String, String> score;
  String fulltimeScore;

  Fixture(this.id, this.league_id, this.eventDate, this.home, this.away,
      this.venue, this.status, this.score, this.timestamp)
      : fulltimeScore = score["fulltime"];

  factory Fixture.fromJson(Map<String, dynamic> json) =>
      _$FixtureFromJson(json);

  Map<String, dynamic> toJson() => _$FixtureToJson(this);

  @override
  String toString() {
    return 'Fixture id: $id ${home.team_name} vs ${away.team_name}\n';
  }

  // score['fulltime'] = String score
}

// NEEDED? To calculate if before match, ongoing, ft and update 'currentScore'?
class Score {
  int homeGoals;
  int awayGoals;

  Score(this.homeGoals, this.awayGoals);
}
