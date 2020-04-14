import 'package:json_annotation/json_annotation.dart';
import 'package:fotmob_clone/models/team.dart';
import 'package:fotmob_clone/models/league.dart';
import 'package:flutter/material.dart';

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
  String dayString;

  Fixture(this.id, this.league_id, this.eventDate, this.home, this.away,
      this.venue, this.status, this.score, this.timestamp)
      : fulltimeScore = score["fulltime"];

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return _$FixtureFromJson(json);
  }
  Map<String, dynamic> toJson() => _$FixtureToJson(this);

  @override
  String toString() {
    return 'Fixture id: $id ${home.team_name} vs ${away.team_name}\n';
  }

  Padding toRow() {
    TextStyle ts = TextStyle(
      fontSize: 13.5,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Text(
                  home.team_name,
                  style: ts,
                  textAlign: TextAlign.end,
                )),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(home.logo),
                      fit: BoxFit.contain,
                    ),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text((fulltimeScore == null) ? 'PST' : 0 - 0, style: ts),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(away.logo),
                      fit: BoxFit.contain,
                    ),
                  ),
                  margin: const EdgeInsets.all(4.0),
                  width: 30,
                  height: 30,
                ),
                Expanded(
                    child: Text(away.team_name,
                        style: ts, textAlign: TextAlign.start)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // score['fulltime'] = String score
}

// NEEDED? To calculate if before match, ongoing, ft and update 'currentScore'?
class Score {
  int homeGoals;
  int awayGoals;

  Score(this.homeGoals, this.awayGoals);
}
