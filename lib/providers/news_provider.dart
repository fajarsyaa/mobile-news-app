import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jars_news_app/models/news_model.dart';

class NewsProvider with ChangeNotifier {
  final apiKey = "97a2a82b43fc457081f8b36087930252";
  List<NewsModel> _news = [];  
  List<NewsModel> _searchResults = [];

  List<NewsModel> get getAllNews {
    return _news;
  }
  List<NewsModel> get searchedNews {
    return _searchResults;
  }

  Future<void> connectApi() async {
    Uri url = Uri.parse("https://newsapi.org/v2/everything?q=indonesia&sortBy=popularity&apiKey=$apiKey");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> sourceData = (json.decode(response.body))['articles'];

      _news = sourceData
          .map((sourceJson) => NewsModel.fromJson(sourceJson))
          .toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load sources');
    }
  }

  Future<void> search(String keyword) async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=${keyword}&popularity&apiKey=$apiKey");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> sourceData = (json.decode(response.body))['articles'];

      _searchResults = sourceData
          .map((sourceJson) => NewsModel.fromJson(sourceJson))
          .toList();

      notifyListeners();      
    }
  }

  Future<List<Map<String, dynamic>>> Trending() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=id&sortBy=popularity&apiKey=$apiKey");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> sourceData = (json.decode(response.body))['articles'];

      List<Map<String, dynamic>> newsList = [];

      for (var article in sourceData) {        
        String imageUrl = article['urlToImage'] == null ? "https://plus.unsplash.com/premium_photo-1688561383203-31fed3d85417?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG5ld3N8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60":article['urlToImage'];

        // Create a new Map with the modified imageUrl
        Map<String, dynamic> modifiedArticle = {
          ...article,
          'urlToImage': imageUrl,
        };

        newsList.add(modifiedArticle);
      }

      return newsList;
    } else {
      throw Exception('Failed to load sources');
    }
  }

  Future<List<Map<String, dynamic>>> CategoryBySource(String id) async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=${id}&apiKey=$apiKey");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> sourceData = (json.decode(response.body))['articles'];

      List<Map<String, dynamic>> newsList = [];

      for (var article in sourceData) {        
        String imageUrl = article['urlToImage'] == null ? "https://plus.unsplash.com/premium_photo-1688561383203-31fed3d85417?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG5ld3N8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60":article['urlToImage'];

        // Create a new Map with the modified imageUrl
        Map<String, dynamic> modifiedArticle = {
          ...article,
          'urlToImage': imageUrl,
        };

        newsList.add(modifiedArticle);
      }

      return newsList;
    } else {
      throw Exception('Failed to load sources');
    }
  }


}
