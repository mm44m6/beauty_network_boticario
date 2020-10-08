import 'package:beauty_network_boticario/controllers/login_controller.dart';
import 'package:beauty_network_boticario/repository/account_repository.dart';
import 'package:beauty_network_boticario/stores/user_store.dart';
import 'package:beauty_network_boticario/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserStore _userStore = Provider.of<UserStore>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: FlatButton(
          child: Text(
            'Sair da aplicação',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            _userStore.setUser('', '', '', '');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView(
                  LoginController(AccountRepository()),
                ),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
    );
  }
}
