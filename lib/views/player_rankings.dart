import 'package:flutter/material.dart';
import 'package:fotmob_clone/database/league_drawer.dart';
import 'package:fotmob_clone/models/league.dart';
import 'package:provider/provider.dart';

class PlayerRankings extends StatelessWidget {
  League _league;

  PlayerRankings();

  @override
  Widget build(BuildContext context) {
    return Consumer<LeagueDrawer>(builder: (context, drawer, child) {
      _league = drawer.currentLeague;
      //TODO: Check if there is some sort of table Widget or package to easily format fixtures and icons
      return Center(
        child: Column(children: [
          Text("${_league.name} player rankings go here"),
        ]),
      );
    });
  }
}
