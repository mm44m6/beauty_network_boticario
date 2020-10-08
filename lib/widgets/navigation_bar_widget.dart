import 'dart:io';

import 'package:beauty_network_boticario/controllers/home_controller.dart';
import 'package:beauty_network_boticario/controllers/news_controller.dart';
import 'package:beauty_network_boticario/repository/news_repository.dart';
import 'package:beauty_network_boticario/views/home_view.dart';
import 'package:beauty_network_boticario/views/menu_view.dart';
import 'package:beauty_network_boticario/views/news_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeNavigationBarWidget extends StatefulWidget {
  @override
  _HomeNavigationBarWidgetState createState() =>
      _HomeNavigationBarWidgetState();
}

class _HomeNavigationBarWidgetState extends State<HomeNavigationBarWidget> {
  int _currentView = 0;
  final List<Widget> _views = [
    HomeView(HomeController()),
    NewsView(NewsController(NewsRepository())),
    MenuView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_currentView],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentView, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
            title: Text('Inicio'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Platform.isIOS ? CupertinoIcons.heart : Icons.favorite),
            title: Text('Novidades'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Platform.isIOS ? CupertinoIcons.ellipsis : Icons.menu),
            title: Text('Menu'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentView = index;
    });
  }
}
