import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Matches',
      style: optionStyle,
    ),
    NewsHomePage(),
    Text(
      'Index 2: Leagues',
      style: optionStyle,
    ),
    Text(
      'Index 3: Faves',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    //TODO: Navigate to NEWS ROUTE
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget choosePageView() {
    return Center(
      child: _widgetOptions[_selectedIndex],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FotMob"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: choosePageView(),
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
            icon: Icon(Icons.school),
            title: Text('Leagues'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text('Favorites'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class NewsHomePage extends StatelessWidget {
  final List<Article> articlesList = [];
  final List<String> imageURLList = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      articlesList.add(Article(
          "http://placekitten.com/600/40$i",
          "Article $i: insert prolonged title here",
          "Subtitle: time stamp $i"));
    }
    return Container(
      child: ListView.builder(
        // itemExtent: 100,
        itemCount: articlesList.length,
        itemBuilder: (BuildContext context, int index) {
          Article article = articlesList[index];
          if (index == 0) {
            return Container(
              height: 400,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      article.thumbnail, //article image
                      Text(article.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      SizedBox(
                        height: 25,
                      ),
                      Text(article.subtitle)
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(
            height: 120,
            margin: EdgeInsets.all(0),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(children: [
                  article.thumbnail,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 200,
                            child: Text(
                              article.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(article.subtitle),
                        ]),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Article {
  ClipRRect thumbnail;
  String imageURL;
  String myTitle;
  String subtitle;
  DateTime dt;
  String ts;

  Article(this.imageURL, this.myTitle, this.subtitle) {
    //TODO: Convert DateTime and URL to Image for thumbnail use
    thumbnail = ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          imageURL,
        ));
  }

  ClipRRect get image => thumbnail;
  String get title => myTitle;
  String get timestamp => ts;
}
