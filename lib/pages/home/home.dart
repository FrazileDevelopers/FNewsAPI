import 'package:flutter/material.dart';
import 'package:fnewsapi/constants/constants.dart';
import 'package:fnewsapi/pages/fullnews/fullnews.dart';
import 'package:fnewsapi/provider/checkinternet.dart';
import 'package:fnewsapi/provider/everthingNews.dart';
import 'package:fnewsapi/provider/topheadlines.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<EverythingNews>(context, listen: false).getHomeData();
    Provider.of<TopHeadlines>(context, listen: false).fetchData();
    Provider.of<InternetStatus>(context, listen: false).updateInternetStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final everythingNews = Provider.of<EverythingNews>(context);
    final internet = Provider.of<InternetStatus>(context);
    final topNews = Provider.of<TopHeadlines>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      drawer: Drawer(
        child: ListView.separated(
            itemBuilder: (c, i) => ListTile(
                  title: Text(
                    topNews.getResponseJson()[i].source!.name!,
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 16.0,
                    ),
                  ),
                ),
            separatorBuilder: (c, i) => Divider(),
            itemCount: topNews.getResponseJson().length),
      ),
      body: !internet.status
          ? Center(
              child: Lottie.asset(
                  'assets/lottie/4760-no-internet-connection.json'),
            )
          : everythingNews.isFetching
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                  ),
                )
              : NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrolling) {
                    if (!everythingNews.isLoading &&
                        scrolling.metrics.pixels ==
                            scrolling.metrics.maxScrollExtent) {
                      everythingNews.loadmore();
                    }
                    return everythingNews.isLoading;
                  },
                  child: ListView.separated(
                    itemBuilder: (c, i) => ListTile(
                        title: Text(everythingNews.getResponseJson()[i].title!),
                        leading: Image.network(
                            everythingNews.getResponseJson()[i].urlToImage!),
                        onTap: () {
                          Constants.title =
                              everythingNews.getResponseJson()[i].title!;
                          Constants.image =
                              everythingNews.getResponseJson()[i].urlToImage!;
                          Constants.content =
                              everythingNews.getResponseJson()[i].content!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullNews(),
                            ),
                          );
                        }),
                    separatorBuilder: (c, i) => Divider(),
                    itemCount: everythingNews.getResponseJson().length,
                  ),
                ),
    );
  }
}
