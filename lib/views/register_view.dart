import 'dart:io';

import 'package:beauty_network_boticario/color_theme_swatch.dart';
import 'package:beauty_network_boticario/controllers/register_controller.dart';
import 'package:beauty_network_boticario/viewmodels/register_view_model.dart';
import 'package:beauty_network_boticario/widgets/custom_appbar_widget.dart';
import 'package:beauty_network_boticario/widgets/loading_widget.dart';
import 'package:beauty_network_boticario/widgets/navigation_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  RegisterView(this._registerController);

  final RegisterControllerInterface _registerController;

  static final _registerFormKey = new GlobalKey<FormState>();

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _userModel = new RegisterViewModel();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool busy;

  void _onSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeNavigationBarWidget()),
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
          title: new Text("Erro no cadastro"),
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
      appBar: CustomAppBarWidget(
        title: 'Cadastre-se',
      ),
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        child: Form(
          key: RegisterView._registerFormKey,
          child: SafeArea(
            child: LoadingWidget(
              busy: busy,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        key: new Key('displayName-input'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                        ),
                        validator: (value) {
                          if (value.isEmpty) return 'Nome é obrigatório';
                          return null;
                        },
                        onSaved: (value) {
                          _userModel.displayName = value;
                          print(value);
                        },
                      ),
                    ),
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
                          'Cadastrar',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: ColorThemeSwatch.boticarioWhite),
                        ),
                        onPressed: () {
                          if (RegisterView._registerFormKey.currentState
                              .validate()) {
                            setState(
                              () {
                                busy = true;
                              },
                            );
                            RegisterView._registerFormKey.currentState.save();
                            print(_userModel);
                            widget._registerController
                                .register(_userModel)
                                .then((_) => _onSuccess())
                                .catchError((error) => _onError(error))
                                .whenComplete(() => _onComplete());
                          }
                        },
                      ),
                    ),
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
