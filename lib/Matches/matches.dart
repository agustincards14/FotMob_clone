import 'package:flutter/material.dart';
import 'package:fotmob_clone/league.dart';

class MatchHome extends StatelessWidget {
  League _league;
  String leaguename;
  String confname;
  // Conference _conf;
  MatchHome(this._league, this.confname) : leaguename = _league.name
  // confname = _conf.name;
  ;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Matches for $leaguename : $confname")
        //Column(
        // children: <Widget>[],
        );
  }
}
