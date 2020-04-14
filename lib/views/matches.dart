import 'package:flutter/material.dart';
import 'package:fotmob_clone/database/league_drawer.dart';

import 'package:fotmob_clone/models/fixture.dart';
import 'package:fotmob_clone/models/gameweek.dart';
import 'package:fotmob_clone/models/league.dart';
import 'package:provider/provider.dart';

class MatchHome extends StatelessWidget {
  List<Fixture> fixtures;
  String leaguename;
  League currentLeague;
  Gameweek gameweek;
  int gameweekInt;

  MatchHome(this.fixtures, this.gameweekInt);

  @override
  Widget build(BuildContext context) {
    //fixtures=currentLeague.what?? do fixtures update auto when dependency changes?
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      children: <Widget>[
        Card(
          //semanticContainer: false,
          elevation: 2,
          child: Column(
            children: fixtures.map((fix) => fix.toRow()).toList(),
          ),
        ),
        Card(
          child: Container(
            child: Text("Gameday #2"),
            height: 100,
          ),
        ),
        Card(
          child: Container(
            child: Text("Gameday #2"),
            height: 100,
          ),
        ),
      ],
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
