import 'package:fotmob_clone/models/team_standing.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fotmob_clone/models/gameweek.dart';

//part 'league.g.dart';
//TODO: make this class serializable, creating and adding League to League Set when we GET fixtures['league']
//@JsonSerializable(ignoreUnannotated: true)
class League {
  //@JsonKey()
  String name;
  //@JsonKey()
  int league_id;
  //@JsonKey()
  String logo;
  List<Gameweek> gameweeks = [];
  int importance = 0;
  List<TeamStanding> standings = [];

  League(this.league_id, this.name, this.logo);

  void addGameweek(Gameweek gw) {
    gameweeks.add(gw);
  }

  //factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  //Map<String, dynamic> toJson() => _$LeagueToJson(this);
}
