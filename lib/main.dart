import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fotmob_clone/database/league_drawer.dart';
import 'package:fotmob_clone/database/my_client.dart';
import 'package:fotmob_clone/models/gameweek.dart';
import 'package:fotmob_clone/views/matches.dart';
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
      home: HomeScaffold(),
      routes: {'/news': (context) => NewsHomePage()},
    );
  }
}

class HomeScaffold extends StatefulWidget {
  HomeScaffold({Key key}) : super(key: key);

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
                .toList());
        break;

      case 1: //News Page
        return NewsHomePage();
        break;

      case 2: //Teams Page
        return TabBarView(children: [
          Standings(),
          Text('2nd tab'),
          Text('3rd tab'),
        ]);
        break;
      default:
        return AlertDialog(
          title: Text("Page View Error"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('leagueDrawer.currentleague: ${leagueDrawer.currentLeague.name}');
    // try {
    //   _currentLeague = leagueDrawer.currentLeague;
    //   assert(_currentLeague != null);
    //   _gameweeks = _currentLeague.gameweeks;
    //   assert(_gameweeks != null);
    //   print(
    //       'There are ${_gameweeks.length} gameweeks for ${_currentLeague.name}');
    // } catch (e, s) {
    //   print('Exception details:\n $e');
    //   print('Stack trace:\n $s');
    // }

    //TODO: ^ THIS CODE HERE LeagueDrawer() creates a NEW instance of drawer BECAUSE it is not singleton.
    // Therefore, the code above passes the assertion, but everytime I try to build a widget using LeagueDrawer
    //as provider, it is using a FRESH object, not the one I originally populated

    return DefaultTabController(
      initialIndex: 0,
      length: //
          3, // 3 days will be the # of tabs on the MATCHES VIEW ONLY (last/current/next GW)
      //TODO: What tab options should I introduce on Standings VIEW? Maybe player rankings (top scorers/saves/assists)?
      //DefaultTabController.of(context).length;
      child: Consumer<LeagueDrawer>(
        builder: (context, drawer, child) {
          _currentLeague = drawer.currentLeague;
          return Scaffold(
            appBar: AppBar(
              title: Text("My Soccer App"),
              bottom: _selectedIndex != 1
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(45.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                            isScrollable: true,
                            tabs: _selectedIndex == 0
                                ? //Matches View
                                _currentLeague.gameweeks
                                    .map((gw) =>
                                        Tab(text: "Gameweek ${gw.week}"))
                                    .toList()
                                : //Standings View
                                [
                                    Tab(text: "Table"),
                                    Tab(text: "Stats"),
                                    Tab(text: "Rankings")
                                  ]),
                      ),
                    )
                  : null, //No TabBar on "NEWS" Page, too little news for each conference. Keep it broad
            ),
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
