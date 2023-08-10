import 'package:flutter/material.dart';
import 'package:jars_news_app/pages/list_news_by_source_page.dart';
import 'package:jars_news_app/providers/source_provider.dart';
import 'package:provider/provider.dart';

class SourceNewsPage extends StatelessWidget {
  static const nameRoute = "/SourceNews";
  @override
  Widget build(BuildContext context) {
    return SourceList();
  }
}

class SourceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataSources = Provider.of<SourceProvider>(context);
    final category = ModalRoute.of(context)!.settings.arguments as String;
    dataSources.connectApi(category);
    final sources = dataSources.getAllSources;
    final searchSources = dataSources.searchSources;

    return Scaffold(
      appBar: AppBar(
        title: Text('News Sources'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search news sources...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                dataSources.searchSource(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataSources.searchSources.length > 0
                  ? dataSources.searchSources.length
                  : dataSources.getAllSources.length,
              itemBuilder: (context, index) {
                final source = dataSources.searchSources.length > 0
                    ? dataSources.searchSources[index]
                    : dataSources.getAllSources[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(source.name),
                      ),
                      subtitle: Text(source.description),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ListNewsBySourcePage.nameRoute,
                          arguments: source.id
                        );
                      },
                      trailing: Icon(Icons.arrow_forward),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
