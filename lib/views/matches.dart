import 'package:flutter/material.dart';
import 'package:fotmob_clone/database/league_drawer.dart';

import 'package:fotmob_clone/models/fixture.dart';
import 'package:fotmob_clone/models/league.dart';
import 'package:provider/provider.dart';

class MatchHome extends StatelessWidget {
  List<Fixture> fixtures;
  String leaguename;
  League currentLeague;
  int gameweekInt;

  MatchHome(this.fixtures, this.gameweekInt);

  @override
  Widget build(BuildContext context) {
    return Consumer<LeagueDrawer>(
      //DO I EVEN NEED CONSUMER HERE? I think YES in order to rebuild this widget when LeagueDrawer updates
      //IF MatchesView depends on Gameweek, which already depends on current League
      builder: (context, drawer, child) {
        assert(drawer.currentLeague != null);
        currentLeague = drawer.currentLeague;

        //fixtures=currentLeague.what?? do fixtures update auto when dependency changes?

        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                  "${currentLeague.name} fixtures here for round $gameweekInt"),
            ],
          ),
        );
      }, // builder
    );
  }

  Widget MatchDay() {
    // build Panel/List Widget for each Match Day in the Gameweek Tab View
    //TODO: Check if there is some sort of table Widget or package to easily format fixtures and icons
  }

  Widget Match() {
    //TODO: build individual match widget to display in Matchday panel
  }
}
