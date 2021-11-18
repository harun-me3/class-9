import 'package:class_9th_ncert_all/books/books.dart';
import 'package:class_9th_ncert_all/drawer_menu/drawermenu.dart';
import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    final _drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
        
        body: ZoomDrawer(
        controller: _drawerController,
        style: DrawerStyle.Style1,
        mainScreen:Books(_drawerController),
        menuScreen:MyDrawer(),
        borderRadius: 26.0,
        angle: 0.0,
        slideWidth: MediaQuery.of(context).size.width *.60,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.easeInOut,
      ),
    );
  }
}