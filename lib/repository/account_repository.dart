import 'package:firebase_auth/firebase_auth.dart' as _firebaseAuth;

abstract class AccountRepositoryInterface {
  Future<_firebaseAuth.User> signIn(model);
  Future<_firebaseAuth.User> register(model);
}

class AccountRepository implements AccountRepositoryInterface {
  Future<_firebaseAuth.User> signIn(model) async {
    try {
      _firebaseAuth.UserCredential userCredential =
          await _firebaseAuth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      return userCredential.user;
    } on _firebaseAuth.FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  Future<_firebaseAuth.User> register(model) async {
    try {
      _firebaseAuth.UserCredential userCredential = await _firebaseAuth
          .FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      await userCredential.user.updateProfile(
        displayName: model.displayName,
        photoURL: '',
      );

      return _firebaseAuth.FirebaseAuth.instance.currentUser;
    } on _firebaseAuth.FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }
}
