import 'package:flutter/material.dart';
import 'package:fnewsapi/constants/constants.dart';

class FullNews extends StatefulWidget {
  FullNews({Key? key}) : super(key: key);

  @override
  _FullNewsState createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height;
    final width = mq.size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * .3,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(Constants.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: width * .98,
              child: Center(
                child: Text(
                  Constants.title!,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: width * .98,
              child: Center(
                child: Text(
                  Constants.content!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
