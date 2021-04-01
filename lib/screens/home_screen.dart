import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List articles;

  Future fetchHeadLines() async {
    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=2021-03-01&sortBy=publishedAt&apiKey=41cfc53c8bdf4f9d934277c626d0eb2c";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        Map result = jsonDecode(response.body);
        articles = result['articles'];
      });
    } else {
      throw Exception("failed to get news");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHeadLines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NEWS'),
        ),
        body: ListView.builder(
            shrinkWrap: true,
              itemCount: articles == null ? 0 : articles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  leading: Image.network(articles[index]['urlToImage'] == null ? ' ': articles[index]['urlToImage']),
                  title: Text(articles[index]['title']),
                  subtitle: Text(articles[index]['content']),
                );
              }),
        );
  }
}
