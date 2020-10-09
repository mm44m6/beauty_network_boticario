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
  Future<QuerySnapshot> _posts;

  @override
  void initState() {
    _posts = widget._homeController.getRecentPosts();
    super.initState();
  }

  void _handleChanges() {
    setState(() {
      _posts = widget._homeController.getRecentPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserStore _userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: CustomAppBarWidget(title: ''),
      body: RefreshIndicator(
        onRefresh: () {
          _handleChanges();
          return _posts;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
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
                  future: _posts,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (snapshot.hasData) {
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
