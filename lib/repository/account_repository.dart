import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRepositoryInterface {
  Future<UserCredential> signIn(model);
}

class AccountRepository implements AccountRepositoryInterface {
  Future<UserCredential> signIn(model) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }
}
