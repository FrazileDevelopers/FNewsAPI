import 'package:flutter/material.dart';
import 'package:fnewsapi/pages/home/home.dart';
import 'package:fnewsapi/provider/provider.dart';
import 'package:provider/provider.dart';

class Config extends StatefulWidget {
  const Config({Key? key}) : super(key: key);

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News API',
        theme: ThemeData(accentColor: Colors.pink, primaryColor: Colors.pink),
        home: HomePage(),
      ),
    );
  }
}
