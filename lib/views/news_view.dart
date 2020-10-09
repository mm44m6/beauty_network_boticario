import 'package:beauty_network_boticario/controllers/news_controller.dart';
import 'package:beauty_network_boticario/models/post_model.dart';
import 'package:beauty_network_boticario/widgets/custom_appbar_widget.dart';
import 'package:beauty_network_boticario/widgets/news_post_card_widget.dart';
import 'package:flutter/material.dart';

class NewsView extends StatefulWidget {
  final NewsControllerInterface _newsController;

  NewsView(this._newsController);

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  Future<List<PostModel>> _news;

  @override
  void initState() {
    _news = widget._newsController.getAllNews();
    super.initState();
  }

  void _handleChanges() {
    setState(() {
      _news = widget._newsController.getAllNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Novidades Boticario'),
      body: RefreshIndicator(
        displacement: 50,
        onRefresh: () {
          _handleChanges();
          return _news;
        },
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _news,
            builder: (BuildContext context,
                AsyncSnapshot<List<PostModel>> snapshot) {
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
                return new ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.map(
                    (post) {
                      return NewsPostCardWidget(post: post);
                    },
                  ).toList(),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
