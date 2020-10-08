import 'package:beauty_network_boticario/viewmodels/create_post_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeControllerInterface {
  Future<QuerySnapshot> getRecentPosts();
  Future<void> createNewPost(CreatePostViewModel post);
  Future<void> deletePost(String documentId);
  Future<void> updatePost(String documentId, String newText);
}

class HomeController implements HomeControllerInterface {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  Future<QuerySnapshot> getRecentPosts() async {
    try {
      QuerySnapshot recentPosts =
          await posts.limit(10).orderBy('date', descending: true).get();
      return recentPosts;
    } catch (error) {
      throw (error);
    }
  }

  Future<void> createNewPost(CreatePostViewModel post) async {
    try {
      return await posts.add({
        'user_uid': post.userUid,
        'user_displayName': post.userDisplayName,
        'text': post.text,
        'date': Timestamp.fromDate(DateTime.now())
      });
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deletePost(String documentId) async {
    try {
      return await posts.doc(documentId).delete();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updatePost(String documentId, String newText) async {
    try {
      return await posts.doc(documentId).update({'text': newText});
    } catch (error) {
      throw (error);
    }
  }
}
