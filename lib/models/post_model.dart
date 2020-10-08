import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as _firebaseAuth;

class PostModel {
  _firebaseAuth.User user;
  String text;
  Timestamp date;

  PostModel({this.user, this.text, this.date});

  PostModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    text = json['text'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['text'] = this.text;
    data['date'] = this.date;
    return data;
  }
}
