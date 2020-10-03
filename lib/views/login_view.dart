import 'package:beauty_network_boticario/color_theme_swatch.dart';
import 'package:beauty_network_boticario/controllers/login_controller.dart';
import 'package:beauty_network_boticario/viewmodels/login_view_model.dart';
import 'package:beauty_network_boticario/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView(this._loginController);

  final LoginControllerInterface _loginController;

  static final _loginFormKey = new GlobalKey<FormState>();
  final LoginViewModel _userModel = new LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(119, 149, 128, 1),
      appBar: CustomAppBarWidget(title: 'Login'),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _loginFormKey,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    key: new Key('email-input'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'E-mail é obrigatório';
                      return null;
                    },
                    onSaved: (value) {
                      _userModel.email = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    key: new Key('password-input'),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Senha'),
                    validator: (value) {
                      if (value.isEmpty) return 'Senha é obrigatória';
                      return null;
                    },
                    onSaved: (value) {
                      _userModel.password = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: ColorThemeSwatch.boticarioWhite),
                    ),
                    onPressed: () {
                      if (_loginFormKey.currentState.validate())
                        _loginFormKey.currentState.save();

                      _loginController.login(_userModel);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: ColorThemeSwatch.boticarioWhite[800],
                      ),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
