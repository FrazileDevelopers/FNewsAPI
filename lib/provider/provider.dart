import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'checkinternet.dart';
import 'everthingNews.dart';
import 'topheadlines.dart';

class Providers {
  static List<SingleChildWidget> providers() => [
        ChangeNotifierProvider<InternetStatus>(
          create: (_) => InternetStatus(),
        ),
        ChangeNotifierProvider<EverythingNews>(
          create: (_) => EverythingNews(),
        ),
        ChangeNotifierProvider<TopHeadlines>(
          create: (_) => TopHeadlines(),
        ),
      ];
}
