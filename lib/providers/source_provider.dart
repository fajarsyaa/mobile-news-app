import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jars_news_app/models/source_model.dart';

class SourceProvider with ChangeNotifier {
  final apiKey = "97a2a82b43fc457081f8b36087930252";
  List<SourceModel> _sources = [];

  List<Map<String, dynamic>> _searchSources = [];

  List<SourceModel> get getAllSources {
    return _sources;
  }

  List<SourceModel> get searchSources {
    return _searchSources
        .map((sourceData) => SourceModel.fromJson(sourceData))
        .toList();
  }

  Future<void> connectApi(String category) async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines/sources?category=${category}&sortBy=popularity&apiKey=$apiKey");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> sourceData = (json.decode(response.body))['sources'];

      _sources = sourceData
          .map((sourceJson) => SourceModel.fromJson(sourceJson))
          .toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load sources');
    }
  }

  void searchSource(String id) {
    final filteredSources = _sources
        .where((source) => source.name.toString().toLowerCase() == id.toString().toLowerCase())
        .toList();

    final newsList = filteredSources.map<Map<String, dynamic>>((source) {
      final url = source.url;
      final defaultUrl =
          "https://plus.unsplash.com/premium_photo-1688561383203-31fed3d85417?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG5ld3N8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60";

      final fixUrl = url ?? defaultUrl;

      return {
        'id': source.id,
        'name': source.name,
        'description': source.description,
        'category': source.category,
        'language': source.language,
        'country': source.country,
        'url': fixUrl,
      };
    }).toList();
    
    _searchSources = newsList;
    notifyListeners();
  }
}
