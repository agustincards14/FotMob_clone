// each GW has a list of Fixtures
import 'package:json_annotation/json_annotation.dart';
import 'package:fotmob_clone/models/fixture.dart';
import 'package:fotmob_clone/models/league.dart';

part 'gameweek.g.dart';

//https://api-football-v1.p.rapidapi.com/v2/fixtures/league/524/last/10 ['api]

@JsonSerializable(ignoreUnannotated: true)
class Gameweek {
  @JsonKey()
  List<Fixture> fixtures;
  @JsonKey()
  int results;
  int week; //TODO: which gw is it? 12,18, 20? How to calculate this?
  int totalGames; //need this?
  League _league;
  //needed? If parent League rebuilds children upon change, GameWeek shouldn't care about League?

  Gameweek(this.results, this.fixtures);

  factory Gameweek.fromJson(Map<String, dynamic> json) =>
      _$GameweekFromJson(json);

  Map<String, dynamic> toJson() => _$GameweekToJson(this);

  @override
  String toString() => "{${fixtures.toString()}}";
}
