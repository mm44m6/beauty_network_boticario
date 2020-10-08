import 'package:beauty_network_boticario/models/user_model.dart';
import 'package:beauty_network_boticario/repository/account_repository.dart';
import 'package:beauty_network_boticario/viewmodels/login_view_model.dart';

abstract class LoginControllerInterface {
  Future<UserModel> login(LoginViewModel model);
  Future<UserModel> logout();
}

class LoginController implements LoginControllerInterface {
  final AccountRepositoryInterface _accountRepository;

  LoginController(this._accountRepository);

  @override
  Future<UserModel> login(LoginViewModel model) async {
    var user = await _accountRepository.login(model);
    return UserModel(
        uid: user.uid,
        profilePicture: user.photoURL,
        displayName: user.displayName);
  }

  Future<UserModel> logout() async {}
}
