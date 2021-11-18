import 'package:class_9th_ncert_all/QandA/Page/Profile/Profile.dart';
import 'package:class_9th_ncert_all/QandA/Page/Quiz/quiz.dart';
import 'package:class_9th_ncert_all/QandA/Page/Spinner/spineer.dart';
import 'package:class_9th_ncert_all/QandA/Page/Task/task.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class QAhome extends StatefulWidget {
  const QAhome({Key? key}) : super(key: key);

  @override
  _QAhomeState createState() => _QAhomeState();
}

class _QAhomeState extends State<QAhome> {
  final GlobalKey<CurvedNavigationBarState> bottomnavigationkey =
      GlobalKey<CurvedNavigationBarState>();

  int _page = 0;
  final items = <Widget>[
    Icon(Icons.air_sharp),
    Icon(Icons.air_sharp),
    Icon(Icons.air_sharp),
    Icon(Icons.air_sharp),
  ];
  var screens = [Spinner(), Quiz(), Task(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomnavigationkey,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.red,
        items: items,
        index: _page,
        onTap: (taponindex) {
          setState(() {
            _page = taponindex;
          });
        },
      ),
    );
  }
}
