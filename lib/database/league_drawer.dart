import 'package:fotmob_clone/models/league.dart';
import 'package:flutter/material.dart';

class LeagueDrawer extends ChangeNotifier {
  List<League> allLeagues = [];
  League _currentLeague;
  int _currentIndex;

  static LeagueDrawer _singleton = LeagueDrawer._internal();

  LeagueDrawer._internal();

  factory LeagueDrawer() => _singleton;

  void populate(List leagues) {
    allLeagues = leagues;
    _currentLeague = allLeagues[0];
    _currentIndex = 0;
  }

  void updateLeague(League l) {
    _currentLeague = l;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

  League get currentLeague => _currentLeague;

  void addLeague(League league) {
    allLeagues.add(league);
    print('league added to storage');
  }
}
