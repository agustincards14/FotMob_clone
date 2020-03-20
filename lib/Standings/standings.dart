import 'package:flutter/material.dart';
import '../league.dart';

class StandingsHomePage extends StatefulWidget {
  final League _league;
  final String leaguename;
  final String confname;
  // Conference _conf;
  StandingsHomePage(this._league, this.confname) : leaguename = _league.name
  // confname = _conf.name;
  ;

  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Text("Standings for $leaguename : $confname\n"),
      ]),
      //Column(
      // children: <Widget>[],
    );
  }

  @override
  State<StatefulWidget> createState() => _StandingsHomePageState(confname);
}

class _StandingsHomePageState extends State<StandingsHomePage> {
  String confName;
  _StandingsHomePageState(this.confName);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: generateList(confName),
        ),
      ),
    );
  }
}

List<Widget> generateList(String confName) {
  String conf = confName;
  List<ExpansionTile> list = List();
  for (var i = 0; i < 10; i++) {
    list.add(
      ExpansionTile(
        title: Text('tile $i'),
        subtitle: Text('$conf'),
      ),
    );
  }
  return list;
}

Widget _buildPanel() {
  return Container(
    child: ListView(
      children: List.generate(
          5, (index) => ExpansionTile(title: Text('tile $index'))),
    ),
  );
}
