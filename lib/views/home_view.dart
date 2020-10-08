import 'package:beauty_network_boticario/controllers/home_controller.dart';
import 'package:beauty_network_boticario/stores/user_store.dart';
import 'package:beauty_network_boticario/widgets/create_post_widget.dart';
import 'package:beauty_network_boticario/widgets/custom_appbar_widget.dart';
import 'package:beauty_network_boticario/widgets/home_post_card_widget.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  final HomeControllerInterface _homeController;

  HomeView(this._homeController);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<QuerySnapshot> posts;

  void _handleChanges() {
    setState(() {
      posts = widget._homeController.getRecentPosts();
    });
  }

  @override
  void initState() {
    posts = widget._homeController.getRecentPosts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserStore _userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: CustomAppBarWidget(title: ''),
      body: RefreshIndicator(
        onRefresh: () {
          _handleChanges();
          return posts;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Olá, ${_userStore.displayName}',
                    style: Theme.of(context).textTheme.headline5),
                CreatePostWidget(
                  widget._homeController,
                  user: _userStore,
                  handleChanges: _handleChanges,
                ),
                Container(
                  child: Text(
                    'Últimos posts',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                FutureBuilder(
                  future: posts,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData) {
                      print(snapshot.data.docs);
                      return new Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data.docs.map(
                            (DocumentSnapshot document) {
                              return HomePostCardWidget(
                                widget._homeController,
                                document: document,
                                user: _userStore,
                                handleChanges: _handleChanges,
                              );
                            },
                          ).toList(),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
