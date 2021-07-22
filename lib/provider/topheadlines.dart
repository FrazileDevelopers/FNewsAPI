import 'dart:convert';
import 'package:flutter/material.dart';
import '/constants/connectionStatus.dart';
import 'package:http/http.dart' as http;
import 'models/topheadlines.dart';

class TopHeadlines with ChangeNotifier {
  TopHeadlines();

  bool _isFetching = false;
  List<Article> newsData = [];

  ConnectionStatus connection = ConnectionStatus.getInstance();

  bool get isFetching => _isFetching;

  Future<List<Article>> fetchData() async {
    _isFetching = true;
    String jsonResponse = '';
    notifyListeners();
    await connection.checkConnection();

    if (connection.hasConnection) {
      var url = Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=c860ac1e8ca040b58175d7c8386f9797');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        jsonResponse = response.body;
      }

      print(jsonResponse.toString());
    }

    _isFetching = false;
    notifyListeners();

    if (jsonResponse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(jsonResponse);
      newsData = Top.fromJson(json).articles!;
    }
    return newsData;
  }

  List<Article> getResponseJson() => newsData;
}
