import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeControllerInterface {
  Future<QuerySnapshot> getRecentPosts();
}

class HomeController implements HomeControllerInterface {
  Future<QuerySnapshot> getRecentPosts() async {
    try {
      var recentPosts = await FirebaseFirestore.instance
          .collection('posts')
          .limit(10)
          .orderBy('data', descending: true)
          .get();
      return recentPosts;
    } catch (e) {
      throw (e);
    }
  }
}
