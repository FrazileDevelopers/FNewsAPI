import 'dart:convert';
import 'package:flutter/material.dart';
import '/constants/connectionStatus.dart';
import '/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'models/everythingModel.dart';

class EverythingNews with ChangeNotifier {
  EverythingNews();

  bool _isFetching = false;
  bool _isLoading = false;
  List<Article> newsData = [];

  ConnectionStatus connection = ConnectionStatus.getInstance();

  bool get isFetching => _isFetching;
  bool get isLoading => _isLoading;

  void loadmore() async {
    Constants.page = Constants.page + 1;
    List<Article> news = await fetchData(page: Constants.page);
    newsData.addAll(news);
    notifyListeners();
  }

  void getHomeData() async {
    List<Article> news = await fetchData(page: 1);
    newsData.addAll(news);
    notifyListeners();
  }

  Future<List<Article>> fetchData({int? page}) async {
    page == 1 ? _isFetching = true : _isLoading = true;
    String jsonResponse = '';
    notifyListeners();
    await connection.checkConnection();

    if (connection.hasConnection) {
      var url = Uri.parse(Constants.baseURL +
          Constants.everything +
          Constants.query +
          Constants.apiKey +
          Constants.key +
          Constants.pSize +
          Constants.pageSize.toString() +
          Constants.p +
          Constants.page.toString());
      var response = await http.get(url);

      if (response.statusCode == 200) {
        jsonResponse = response.body;
      }
    }

    page == 1 ? _isFetching = false : _isLoading = false;
    notifyListeners();

    List<Article> walls = [];
    if (jsonResponse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(jsonResponse);
      walls = Everything.fromJson(json).articles!;
    }
    return walls;
  }

  List<Article> getResponseJson() => newsData;
}
