import 'package:beauty_network_boticario/repository/account_repository.dart';
import 'package:beauty_network_boticario/viewmodels/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginControllerInterface {
  Future<UserCredential> login(LoginViewModel model);
}

class LoginController implements LoginControllerInterface {
  final AccountRepositoryInterface _accountRepository;

  LoginController(this._accountRepository);

  @override
  Future<UserCredential> login(LoginViewModel model) async {
    var user = await _accountRepository.signIn(model);
    return user;
  }
}
