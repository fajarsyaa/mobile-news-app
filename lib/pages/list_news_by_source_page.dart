import 'package:flutter/material.dart';
import 'package:jars_news_app/pages/detail_news_page.dart';
import 'package:jars_news_app/providers/news_provider.dart';
import 'package:provider/provider.dart';

class ListNewsBySourcePage extends StatelessWidget {
  static const nameRoute = "/ListNewsBySorcePage";

  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<NewsProvider>(context);
    final sourceId = ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: newsData.CategoryBySource(sourceId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final trendingNews = snapshot.data;

          if (trendingNews == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text("News By " + sourceId),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Text(
                    'load data....',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 29,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("News By " + sourceId),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: trendingNews.length,
              itemBuilder: (context, index) {
                final news = trendingNews[index];
                return listNewsBySource(
                  title: news['title'],
                  description: news['description'],
                  image: news['urlToImage'],
                  content: news['content'],
                  author: news['author'],
                  sourceName: news['source']['name'],
                  publishedAt: news['publishedAt'],
                  url: news['url'],
                );
              },
            ),
          );
        }
      },
    );
  }
}

class listNewsBySource extends StatelessWidget {
  final String title;
  final String? description;
  final String? image;
  final String? content;
  final String? author;
  final String? sourceName;
  final String? publishedAt;
  final String? url;

  listNewsBySource({
    required this.title,
    this.description,
    this.image,
    this.content,
    this.author,
    this.sourceName,
    this.publishedAt,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.network(
              image.toString(),
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(description.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(NewsDetailPage.nameRoute, arguments: {
          'title': title.toString(),
          'imageUrl': image.toString(),
          'content': content.toString(),
          'author': author.toString(),
          'source': sourceName.toString(),
          'publishAt': publishedAt.toString(),
          'url': url.toString(),
        });
      },
    );
  }
}
