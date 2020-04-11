//News have a league associated, only displaying news for THAT LEAGUE
//Get twitter API. That will be main source of news because it's free,
//don't have to worry about full articles. Just embed Tweets about topic. EASY.
import 'package:fotmob_clone/models/league.dart';
import 'package:flutter/widgets.dart';

class NewsModel {
  League league;
  Article leadArticle;
  List<Article> articles;
}

class Article {
  Image thumbnail;
  String imageURL;
  String myTitle;
  String subtitle;
  DateTime dt;
  String ts;

  Article(this.imageURL, this.myTitle, this.subtitle) {
    //TODO: Convert DateTime and URL to Image for thumbnail use
    thumbnail = Image.network(
      imageURL,
    );
  }

  Image get image => thumbnail;
  String get title => myTitle;
  String get timestamp => ts;
}
