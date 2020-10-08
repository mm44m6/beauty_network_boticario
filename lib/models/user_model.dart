class UserModel {
  String uid;
  String displayName;
  String email;
  String profilePicture;

  UserModel({this.uid, this.displayName, this.email, this.profilePicture});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['name'];
    email = json['email'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}
