import 'dart:io';

import 'package:beauty_network_boticario/color_theme_swatch.dart';

import 'package:beauty_network_boticario/controllers/login_controller.dart';
import 'package:beauty_network_boticario/controllers/register_controller.dart';

import 'package:beauty_network_boticario/repository/account_repository.dart';

import 'package:beauty_network_boticario/viewmodels/login_view_model.dart';

import 'package:beauty_network_boticario/views/register_view.dart';

import 'package:beauty_network_boticario/widgets/custom_appbar_widget.dart';
import 'package:beauty_network_boticario/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView(this._loginController);

  final LoginControllerInterface _loginController;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _userModel = new LoginViewModel();
  static final _loginFormKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool busy;

  void _onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterView(
          RegisterController(
            AccountRepository(),
          ),
        ),
      ),
    );
  }

  void _onError(error) {
    if (Platform.isAndroid) {
      var snackbar = SnackBar(
        backgroundColor: Theme.of(context).accentColor,
        content: Text(
          "$error",
          style: TextStyle(color: ColorThemeSwatch.boticarioWhite),
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }

    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: new Text("Erro no login"),
          content: new Text("$error"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }
  }

  void _onComplete() {
    setState(() {
      busy = false;
    });
  }

  @override
  void initState() {
    busy = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(119, 149, 128, 1),
      appBar: CustomAppBarWidget(title: 'Login'),
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        margin: EdgeInsets.all(20),
        child: Form(
          key: _loginFormKey,
          child: SafeArea(
            child: LoadingWidget(
              busy: busy,
              child: SingleChildScrollView(
                child: Column(
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
                            color: ColorThemeSwatch.boticarioWhite,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            busy = true;
                          });

                          if (_loginFormKey.currentState.validate()) {
                            _loginFormKey.currentState.save();
                            widget._loginController
                                .login(_userModel)
                                .then((_) => _onSuccess())
                                .catchError((err) => _onError(err))
                                .whenComplete(() => _onComplete());
                          }
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.6),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: ColorThemeSwatch.boticarioWhite[800],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterView(
                                RegisterController(
                                  AccountRepository(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
