import 'package:flutter/material.dart';
import 'package:jars_news_app/pages/category_page.dart';
import 'package:jars_news_app/pages/detail_news_page.dart';
import 'package:jars_news_app/pages/trending_page.dart';
import 'package:jars_news_app/providers/news_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const nameRoute = "/HomePage";

  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<NewsProvider>(context);
    final newsArticles = newsData.getAllNews;
    final searchResults = newsData.searchedNews;

    return Scaffold(
      appBar: AppBar(
        title: Text("Jars News"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 85,
              color: Colors.blueGrey,
              padding: EdgeInsets.only(left: 10, bottom: 5),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.trending_up),
              title: Text("Trending News"),
              onTap: () {
                Navigator.of(context).pushNamed(TrendingPage.nameRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Category News"),
              onTap: () {
                Navigator.of(context).pushNamed(CategoryPage.nameRoute);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search articles...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                newsData.search(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: newsData.searchedNews.length > 0
                  ? newsData.searchedNews.length
                  : newsData.getAllNews.length,
              itemBuilder: (context, index) {
                final article = newsData.searchedNews.length > 0
                    ? newsData.searchedNews[index]
                    : newsData.getAllNews[index];
                return NewsArticleCard(
                  title: article.title,
                  description: article.description,
                  image: article.urlToImage.toString(),
                  content: article.content.toString(),
                  author: article.author.toString(),
                  sourceName: article.sourceName.toString(),
                  publishedAt: article.publishedAt.toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewsArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String content;
  final String? author;
  final String? sourceName;
  final String? publishedAt;

  NewsArticleCard({
    required this.title,
    required this.description,
    required this.image,
    required this.content,
    this.author,
    this.sourceName,
    this.publishedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Column(
          children: [
            Image.network(
              image.toString(),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(title),
          ],
        ),
        subtitle: Text(
          description,
          maxLines: 2,
        ),
        onTap: () {
          Navigator.of(context).pushNamed(NewsDetailPage.nameRoute, arguments: {
            'title': title.toString(),
            'imageUrl': image.toString(),
            'content': content.toString(),
            'author': author.toString(),
            'source': sourceName.toString(),
            'publishAt': publishedAt.toString(),
          });
        },
      ),
    );
  }
}
