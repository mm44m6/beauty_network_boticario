import 'package:beauty_network_boticario/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsPostCardWidget extends StatelessWidget {
  final PostModel post;

  NewsPostCardWidget({this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Image.network(
                    'https://itaquagardenshopping.com.br/wp-content/uploads/2016/04/BOTICARIO.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.user.displayName,
                        style: Theme.of(context).textTheme.subtitle2),
                    Row(
                      children: [
                        Expanded(
                          child: Text(post.content,
                              style: TextStyle(fontSize: 16)),
                        )
                      ],
                    ),
                    Text(
                      timeago.format(
                        DateTime.parse(post.createdAt).toLocal(),
                        locale: 'pt_BR',
                      ),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
