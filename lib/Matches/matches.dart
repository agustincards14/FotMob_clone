import 'package:flutter/material.dart';
import 'package:fotmob_clone/league.dart';
import '';

class MatchHome extends StatefulWidget {
  League _league;
  MatchHome(this._league, {Key key}) : super(key: key);

  @override
  _MatchHomeState createState() => _MatchHomeState(_league);
}

class _MatchHomeState extends State<MatchHome> {
  League _league;
  _MatchHomeState(this._league);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("$_league.name"),
    );
  }
}
