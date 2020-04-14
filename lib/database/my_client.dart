import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:fotmob_clone/models/league.dart';
import 'package:fotmob_clone/database/league_drawer.dart';
import 'package:fotmob_clone/models/gameweek.dart';
import 'package:fotmob_clone/models/team_standing.dart';
import 'package:fotmob_clone/models/fixture.dart';

class MyClient {
  static final MyClient _singleton = new MyClient._internal();
  static const String BASE_URL = "https://api-football-v1.p.rapidapi.com/v2";
  // static const String LEAGUE_STANDINGS_DIR = "/leagueTable/";
  // static const int EPL = 524;
  // static const int LALIGA = 775;
  // static const int BUNDESLIGA = 754;
  // static const int SERIEA = 891;
  LeagueDrawer _leagueDrawer = LeagueDrawer();
  Set<League> allLeagues;
  List<League> topLeagues = [
    League(524, "English Premier League",
        "https://media.api-sports.io/leagues/2.png"),
    League(775, "La Liga", "https://media.api-sports.io/leagues/87.png"),
    League(754, "Bundesliga", "https://media.api-sports.io/leagues/8.png"),
    League(891, "Seria A", "https://media.api-sports.io/leagues/94.png")
  ];

  static const Map<String, String> _headers = {
    'x-rapidapi-host': "api-football-v1.p.rapidapi.com",
    'x-rapidapi-key': "35db49e95amshaa10e60f4df0af6p1fa53ejsn7f417d49e37a"
  };

  factory MyClient() => _singleton;

  MyClient._internal();

  LeagueDrawer get leagueDrawer => _leagueDrawer;

  Future<void> work() async {
    await getRequests();
    populateStorage();
    print('Client work done...');
  }

  Future<void> getRequests() async {
    //Loop through topLeagues List
    for (League league in topLeagues) {
      String currentRoundURL =
          BASE_URL + "/fixtures/rounds/${league.league_id}/current";
      var roundResponse = await http.get(
        currentRoundURL,
        headers: _headers,
      );
      Map<String, dynamic> json = jsonDecode(roundResponse.body);
      String currentRound = json["api"]["fixtures"][0];
      int lastRoundInt = getWeekInt(currentRound) - 1;
      String lastRound = parseString(currentRound, 0);
      String nextRound = parseString(currentRound, 1);
      List<String> roundStrings = [lastRound, currentRound, nextRound];

      await getGameweeks(lastRoundInt, roundStrings, league);
      //TODO: comment out only for MATCHHOME widget construction
      await getStandings(league);
    }
  }

  Future<void> getGameweeks(
      int lastRoundInt, List roundStrings, League league) async {
    int league_id = league.league_id;
    List<Fixture> firstThreefix = [];
    int thisRound = lastRoundInt;
    for (String round in roundStrings) {
      var response = await http.get(
        BASE_URL + '/fixtures/league/$league_id/$round',
        headers: _headers,
      );
      if (response.statusCode == 200) {
        //print('200!');
        Map<String, dynamic> json = jsonDecode(response.body);
        dynamic gameweek = json["api"];
        Gameweek gw = Gameweek.fromJson(gameweek);
        gw.week = thisRound;
        league.addGameweek(gw);
        print("Added Gameweek ${gw.week} to ${league.name}\n");
      } else {
        throw Exception('response status code: ${response.statusCode}');
      }
      thisRound++;
    }
    // league.gameweeks.forEach((gameweek) {
    //   firstThreefix = gameweek.fixtures.take(3).toList();
    //   print(
    //       "${league.name} - first 3 fixtures of Gameweek ${gameweek.week}\n${firstThreefix.toString()}");
    // });
  }

  Future<void> getStandings(League league) async {
    int league_id = league.league_id;
    String standingsURL = BASE_URL + "/leagueTable/$league_id";
    var response = await http.get(
      standingsURL,
      headers: _headers,
    );
    if (response.statusCode == 200) {
      //print('200!');
      Map<String, dynamic> json = jsonDecode(response.body);
      dynamic standingsMap = json["api"]["standings"][0];
      for (Map team in standingsMap) {
        TeamStanding ts = TeamStanding.fromJson(team);
        league.standings.add(ts);
      }
    } else {
      throw Exception('response status code: ${response.statusCode}');
    }
  }

  void populateStorage() {
    //TODO: populate league_storage.dart with
    _leagueDrawer.populate(topLeagues);
    print('populating leaguestorage with :');
    for (League l in topLeagues) {
      print('${l.name},');
    }
  }

  int getWeekInt(String str) {
    RegExp exp = new RegExp(r"(\d)+"); //decimals only regex for gameweek int
    //return last round string
    int week = int.parse(exp.stringMatch(str));
    return week;
  }

  String parseString(String str, int i) {
    String round;
    int length = str.length;

    RegExp exp = new RegExp(r"(\d)+"); //decimals only regex for gameweek int
    //return last round string
    int week = int.parse(exp.stringMatch(str));
    // print('current week: $week');
    //if last week flag true, week - 1, else week+2 for next week
    int newWeek = (i == 0) ? week - 1 : week + 1;
    round = (week < 10)
        ? str.substring(0, length - 1) + '$newWeek'
        : str.substring(0, length - 2) + '$newWeek';
    return round;
  }
}
