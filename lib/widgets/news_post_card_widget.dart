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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.user.displayName,
                  style: Theme.of(context).textTheme.subtitle2),
              Row(
                children: [
                  Expanded(
                    child: Text(post.content, style: TextStyle(fontSize: 16)),
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
      ),
    );
  }
}
