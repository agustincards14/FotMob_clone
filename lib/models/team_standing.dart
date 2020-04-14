import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'team_standing.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class TeamStanding {
  @JsonKey()
  final int rank;
  @JsonKey()
  final int team_id;
  @JsonKey()
  final String teamName;
  @JsonKey()
  final String logo;
  @JsonKey()
  String forme;
  @JsonKey()
  int goalsDiff;
  @JsonKey()
  int points;
  @JsonKey(name: "all")
  Record record;

  TeamStanding(this.rank, this.team_id, this.teamName, this.logo, this.forme);

  factory TeamStanding.fromJson(Map<String, dynamic> json) {
    return _$TeamStandingFromJson(json);
  }

  @override
  String toString() => "(${rank}) - $teamName __${forme}__\n";

  List<String> stringList() {
    return [
      '$rank',
      logo,
      teamName,
      '${record.win}',
      '${record.draw}',
      '${record.lose}',
      '$goalsDiff'
    ];
  }

  TableRow getTableRow() {
    TextStyle ts = TextStyle(
      fontSize: 18.5,
    );
    TableRow tr = TableRow(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: .3, color: Colors.grey)),
        color: Colors.grey[100],
      ),
      children: teamRow(),
      //),
      //],
    );
    return tr;
  }

  List<Widget> teamRow() {
    List<Widget> tr = [];
    List<String> sl = stringList();
    String logo = sl[1];

    for (int i = 0; i < sl.length; i++) {
      tr.add(TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: i == 1
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(logo),
                    fit: BoxFit.contain,
                  ),
                ),
                margin: const EdgeInsets.all(4.0),
                width: 10,
                height: 30,
              )
            : Text(
                sl[i],
                style: TextStyle(fontSize: 18.5),
                textAlign: i == 0 ? TextAlign.center : null,
              ),
      ));
    }
    return tr;
  }
}

@JsonSerializable(ignoreUnannotated: true)
class Record {
  @JsonKey()
  int matchsPlayed;
  @JsonKey()
  int win;
  @JsonKey()
  int draw;
  @JsonKey()
  int lose;
  @JsonKey()
  int goalsFor;
  @JsonKey()
  int goalsAgainst;

  Record(this.matchsPlayed, this.win, this.draw, this.lose, this.goalsFor,
      this.goalsAgainst);

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
