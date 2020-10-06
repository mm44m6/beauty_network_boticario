import 'package:beauty_network_boticario/models/user_model.dart';
import 'package:beauty_network_boticario/repository/account_repository.dart';
import 'package:beauty_network_boticario/viewmodels/register_view_model.dart';

abstract class RegisterControllerInterface {
  Future<UserModel> register(RegisterViewModel model);
}

class RegisterController implements RegisterControllerInterface {
  final AccountRepositoryInterface _accountRepository;

  RegisterController(this._accountRepository);

  @override
  Future<UserModel> register(RegisterViewModel model) async {
    var user = await _accountRepository.register(model);
    return UserModel(
        uid: user.uid, photoURL: user.photoURL, displayName: user.displayName);
  }
}
