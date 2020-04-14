import 'package:flutter/material.dart';
import 'package:fotmob_clone/database/league_drawer.dart';
import 'package:fotmob_clone/models/league.dart';
import 'package:provider/provider.dart';
import 'package:fotmob_clone/models/team_standing.dart';

class Standings extends StatelessWidget {
  League _league;
  // Conference _conf;
  Standings();
  List<TeamStanding> standings;

  @override
  Widget build(BuildContext context) {
    return Consumer<LeagueDrawer>(builder: (context, drawer, child) {
      _league = drawer.currentLeague;
      standings = _league.standings;
      List<TableRow> trList = [];
      for (TeamStanding ts in standings) {
        trList.add(ts.getTableRow());
      }
      return SingleChildScrollView(
        child: Table(
          columnWidths: {
            2: FlexColumnWidth(4),
            6: FlexColumnWidth(1.1),
          },
          defaultColumnWidth: FixedColumnWidth(35),
          children: trList,
        ),
      );
    });
  }
}
