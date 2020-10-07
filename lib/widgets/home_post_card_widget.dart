import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePostCardWidget extends StatelessWidget {
  final DocumentSnapshot document;

  HomePostCardWidget({this.document});

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(document.data()['user'],
                  style: Theme.of(context).textTheme.subtitle2),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(document.data()['text']),
            ),
            Text(
              timeago.format(
                document.data()['data'].toDate(),
                locale: 'pt_BR',
              ),
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }
}
