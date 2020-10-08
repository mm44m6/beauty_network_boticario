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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Novidades Boticario'),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: widget._newsController.getAllNews(),
          builder:
              (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
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
    );
  }
}
