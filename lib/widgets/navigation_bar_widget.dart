import 'dart:io';

import 'package:beauty_network_boticario/controllers/home_controller.dart';
import 'package:beauty_network_boticario/views/create_post_view.dart';
import 'package:beauty_network_boticario/views/home_view.dart';
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
    CreatePostView(),
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
            icon: Icon(Platform.isIOS ? CupertinoIcons.create : Icons.notes),
            title: Text('Escrever'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
                Platform.isIOS ? CupertinoIcons.heart : Icons.wallet_giftcard),
            title: Text('Novidades'),
          )
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
