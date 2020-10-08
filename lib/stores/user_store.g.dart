// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$displayNameAtom = Atom(name: '_UserStore.displayName');

  @override
  String get displayName {
    _$displayNameAtom.reportRead();
    return super.displayName;
  }

  @override
  set displayName(String value) {
    _$displayNameAtom.reportWrite(value, super.displayName, () {
      super.displayName = value;
    });
  }

  final _$emailAtom = Atom(name: '_UserStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$profilePictureAtom = Atom(name: '_UserStore.profilePicture');

  @override
  String get profilePicture {
    _$profilePictureAtom.reportRead();
    return super.profilePicture;
  }

  @override
  set profilePicture(String value) {
    _$profilePictureAtom.reportWrite(value, super.profilePicture, () {
      super.profilePicture = value;
    });
  }

  final _$uidAtom = Atom(name: '_UserStore.uid');

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  void setUser(
      String pDisplayName, String pEmail, String pProfilePicture, String pUid) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setUser');
    try {
      return super.setUser(pDisplayName, pEmail, pProfilePicture, pUid);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
displayName: ${displayName},
email: ${email},
profilePicture: ${profilePicture},
uid: ${uid}
    ''';
  }
}
