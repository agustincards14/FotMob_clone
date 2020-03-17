import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fotmob_clone/Teams/teams.dart';
import 'News/news.dart';
import 'league.dart';
import 'Teams/teams.dart';

void main() => runApp(MyApp());

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
        routes: {'/news': (context) => NewsHomePage()});
  }
}

class HomeScaffold extends StatefulWidget {
  HomeScaffold({Key key}) : super(key: key);

  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  Color _selectedColor = const Color(0xffcbf9c4);
  League _currentLeague;
  int _selectedIndex = 0;
  static League usl =
      League("USL", ["Championship", "League One", "League Two"]);
  static League nisa = League("NISA", ["NISA"]);
  static League npsl = League("NPSL", ["West", "Midwest", "South", "East"]);
  static League upsl = League("UPSL", [
    "Western",
    "Northeast",
    "Southeast",
    "Central",
    "Midwest",
    "Southwest",
    "Mountain"
  ]);
  List<League> _leagues = [usl, nisa, npsl, upsl];

  // List<String> _leagueNames = ["USL", "NISA", "NPSL", "UPSL"];
  // Map<String, int> _leagueTabs = {"USL": 3, "NISA": 1, "NPSL": 4, "UPSL": 7};
  // Map<String, dynamic> _leagueConfs = {
  //   "USL": ["Championship", "League One", "League Two"],
  //   "NISA": ["NISA"],
  //   "NPSL": ["West", "Midwest", "South", "East"],
  //   "UPSL": [
  //     "Western",
  //     "Northeast",
  //     "Southeast",
  //     "Central",
  //     "Midwest",
  //     "Southwest",
  //     "Mountain"
  //   ]
  // };

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const TextStyle drawerStyle =
      TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w100);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Matches',
      style: optionStyle,
    ),
    NewsHomePage(),
    TeamsHomePage(), //route not even used, return NewsHomePage based on index selected in BottomNavigation
  ];

  void _navItemTapped(int index) {
    //TODO: Navigate to NEWS ROUTE
    setState(() {
      _selectedIndex = index;
    });
    print("inside index $_selectedIndex");
  }

  void _newLeagueSelected(League league) {
    setState(() {
      _currentLeague = league;
    });
  }

  TabBarView _returnTabBarView() {
    //need to find a way to track which conference I'm in, in orde to display pageview pertaining to that conf
    // _currentLeague.confs
    return TabBarView(
        children: _currentLeague.conf
            .map((conference) => Center(child: Text("$conference")))
            .toList());
  }

  Widget _choosePageView() {
    switch (_selectedIndex) {
      case 0: //Matches Page
        return TabBarView(
            children: _currentLeague.conf
                .map((conference) => Center(child: Text("$conference")))
                .toList());
        break;

      case 1: //News Page
        return NewsHomePage();
        break;

      case 2: //Teams Page
        return TeamsHomePage();
        break;
      default:
    }
    // return _selectedIndex!=1
    // ? TabBarView(
    //     children: _currentLeague.conf
    //         .map((conference) => Center(child: Text("$conference")))
    //         .toList())
    // :
    // return Center(
    //   child: _widgetOptions[_selectedIndex],
    // );
  }

  @override
  void initState() {
    super.initState();
    _currentLeague = _leagues[0];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: _currentLeague.conf.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Futbol USA"),
          bottom: _selectedIndex != 1
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(45.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(isScrollable: true, tabs: [
                      for (final conf in _currentLeague.conf)
                        Tab(
                          text: conf,
                        )
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
              DrawerHeader(
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
              ),
              for (final l in _leagues)
                Container(
                  color: l == _currentLeague ? _selectedColor : null,
                  child: ListTile(
                    title: Text(l.name),
                    onTap: () {
                      // Update the state of the app
                      _newLeagueSelected(l);
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          ),
        ),
        body: _choosePageView(),
        //TabBarView(children: _returnPageViews()),
        bottomNavigationBar: BottomNavigationBar(
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
              title: Text('Teams'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: _navItemTapped,
        ),
      ),
    );
  }
}
