import 'package:flutter/material.dart';
import 'package:fotmob_clone/database/league_drawer.dart';
import 'package:fotmob_clone/models/league.dart';
import 'package:provider/provider.dart';

class Standings extends StatelessWidget {
  League _league;
  // Conference _conf;
  Standings();

  @override
  Widget build(BuildContext context) {
    return Consumer<LeagueDrawer>(builder: (context, drawer, child) {
      _league = drawer.currentLeague;
      //TODO: Check if there is some sort of table Widget or package to easily format fixtures and icons
      return Center(
        child: Column(children: [
          Text("${_league.name} standings go here"),
        ]),
      );
    });
  }
}

List<Widget> generateList(String confName, BuildContext context) {
  List<Widget> list = List();
  for (var i = 0; i < 5; i++) {
    list.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
          color: Colors.blueGrey[100],
          elevation: 5,
          child: ExpansionTile(
            //TODO: When used with scrolling widgets like ListView, a unique PageStorageKey
            //must be specified to enable the ExpansionTile to save and restore its expanded state when it is scrolled in and out of view.
            backgroundColor: Theme.of(context).cardColor,
            title: Text(
              'conf $i',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            children: [
              Container(
                height: 260,
                child: ListView(children: _buildChildren(i)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return list;
}

List<Widget> _buildChildren(int conf) {
  List<Widget> teams = List();
  int count = 6;
  for (var i = 0; i <= count; i++) {
    teams.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Row(
          children: <Widget>[
            CircleAvatar(child: Text('$i'), radius: 15),
            SizedBox(width: 8),
            Text("Team for conference #$conf"),
          ],
        ),
      ),
    );
    teams.add(Divider());
  }
  return teams;
}

class TeamEntry {}
