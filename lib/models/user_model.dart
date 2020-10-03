class UserModel {
  String uid;
  String displayName;
  String email;
  String photoURL;

  UserModel({this.uid, this.displayName, this.email, this.photoURL});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['displayName'];
    email = json['email'];
    photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['photoURL'] = this.photoURL;
    return data;
  }
}
