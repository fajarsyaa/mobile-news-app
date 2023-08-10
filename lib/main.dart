import 'package:flutter/material.dart';
import 'package:jars_news_app/pages/category_page.dart';
import 'package:jars_news_app/pages/detail_news_page.dart';
import 'package:jars_news_app/pages/home_page.dart';
import 'package:jars_news_app/pages/list_news_by_source_page.dart';
import 'package:jars_news_app/pages/source_page.dart';
import 'package:jars_news_app/pages/trending_page.dart';
import 'package:jars_news_app/providers/news_provider.dart';
import 'package:jars_news_app/providers/source_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsProvider>(create: (_) => NewsProvider()),
        ChangeNotifierProvider<SourceProvider>(create: (_) => SourceProvider()),        
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final newsData = Provider.of<NewsProvider>(context);
    newsData.connectApi();
    return MaterialApp(
      title: 'My App',
      home: HomePage(),
      initialRoute: HomePage.nameRoute,
      routes: {
        HomePage.nameRoute: (context) => HomePage(),
        CategoryPage.nameRoute: (context) => CategoryPage(),
        TrendingPage.nameRoute: (context) => TrendingPage(),        
        NewsDetailPage.nameRoute: (context) => NewsDetailPage(),
        SourceNewsPage.nameRoute: (context) => SourceNewsPage(),
        ListNewsBySourcePage.nameRoute: (context) => ListNewsBySourcePage(),
      },
    );
  }
}
