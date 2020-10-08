import 'package:beauty_network_boticario/models/user_model.dart';

class PostModel {
  UserModel user;
  String content;
  String createdAt;

  PostModel({this.user, this.content, this.createdAt});

  PostModel.fromJson(Map<String, dynamic> json) {
    user = UserModel.fromJson(json['user']);
    content = json['message']['content'];
    createdAt = json['message']['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    return data;
  }
}
