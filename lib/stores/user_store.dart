import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  String displayName = "";

  @observable
  String email = "";

  @observable
  String profilePicture = "https://placehold.it/200";

  @observable
  String uid = "";

  @action
  void setUser(
    String pDisplayName,
    String pEmail,
    String pProfilePicture,
    String pUid,
  ) {
    displayName = pDisplayName;
    email = pEmail;
    profilePicture = pProfilePicture;
    uid = pUid;
  }
}
