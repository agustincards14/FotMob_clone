import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fotmob_clone/database/league_drawer.dart';
import 'package:fotmob_clone/database/my_client.dart';
import 'package:fotmob_clone/models/gameweek.dart';
import 'package:fotmob_clone/views/matches.dart';
import 'package:fotmob_clone/views/player_rankings.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:fotmob_clone/models/league.dart';
import 'package:fotmob_clone/views/news.dart';
import 'package:fotmob_clone/views/standings.dart';

void main() async {
  MyClient myClient = new MyClient();
  await myClient.work();

  return runApp(
    ChangeNotifierProvider(
      create: (context) => LeagueDrawer(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff45a35e),
        primaryColorLight: const Color(0xff51bf6e),
        accentColor: const Color(0xffcddc39),
      ),
      home: HomeScaffold("Simple Soccer"),
      routes: {'/news': (context) => NewsHomePage()},
    );
  }
}

class HomeScaffold extends StatefulWidget {
  HomeScaffold(this.title, {Key key}) : super(key: key);
  String title;
  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  Color _league_selectedColor = const Color(0xffcbf9c4);
  int _selectedIndex = 0;

  // static MyClient myClient = MyClient();
  // static LeagueDrawer leagueDrawer = myClient.leagueDrawer;
  League _currentLeague;
  // List<League> allLeagues = leagueDrawer.allLeagues;
  List<Gameweek> _gameweeks;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const TextStyle drawerStyle =
      TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w100);

  void _navItemTapped(int index) {
    //TODO: Navigate to NEWS ROUTE
    setState(() {
      _selectedIndex = index;
    });
    print("inside index $_selectedIndex");
  }

  Widget _choosePageView() {
    switch (_selectedIndex) {
      case 0: //Matches Page
        return TabBarView(
          //map list of fixtures from each gameweek from the current league into the MatchHome Widget to display
          children: _currentLeague.gameweeks
              .map((gw) => MatchHome(gw.fixtures, gw.week))
              .toList(),
        );
        break;

      case 1: //News Page
        return NewsHomePage();
        break;

      case 2: //Teams Page
        return TabBarView(
          //map list of fixtures from each gameweek from the current league into the MatchHome Widget to display
          children: [
            Standings(),
            //PlayerRankings(),
          ],
        );
        break;
      default:
        return AlertDialog(
          title: Text("Page View Error"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool onMatchPage = _selectedIndex == 0;
    bool onStandings = _selectedIndex == 2;
    return DefaultTabController(
      length: onMatchPage ? 3 : onStandings ? 1 : 0,
      initialIndex: onMatchPage ? 1 : 0,
      child: Consumer<LeagueDrawer>(
        builder: (context, drawer, child) {
          _currentLeague = drawer.currentLeague;
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "My Soccer App",
                ),
                bottom: !(onMatchPage || onStandings)
                    ? null
                    : PreferredSize(
                        preferredSize: const Size.fromHeight(45.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: TabBar(
                            isScrollable: true,
                            tabs: onMatchPage
                                ? //Matches View
                                _currentLeague.gameweeks
                                    .map((gw) =>
                                        Tab(text: "Gameweek ${gw.week}"))
                                    .toList()
                                : //Standings View
                                [
                                    Tab(text: "Table")
                                    // Tab(text: "Rankings"),
                                  ],
                          ),
                        ),
                      )),
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  drawerHeader(),
                  for (League l in drawer.allLeagues)
                    Container(
                      color: l == _currentLeague ? _league_selectedColor : null,
                      child: ListTile(
                        title: Text(l.name),
                        onTap: () {
                          // Update the state of the app to show new league data
                          setState(() {
                            drawer.updateLeague(l);
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                ],
              ),
            ),
            body: _choosePageView(),
            //TabBarView(children: _returnPageViews()),
            bottomNavigationBar: getNavBar(),
          );
        }, //builder
      ),
    );
  }

  Widget drawerHeader() {
    return DrawerHeader(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Drawer Header',
          style: drawerStyle,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }

  Widget getNavBar() {
    return BottomNavigationBar(
      // unselectedItemColor: const Color(0xffb0bec5),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.phone_android),
          title: Text('Matches'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fiber_new),
          title: Text('News'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          title: Text('Standings'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: _navItemTapped,
    );
  }
}
