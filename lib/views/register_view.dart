import 'package:beauty_network_boticario/color_theme_swatch.dart';
import 'package:beauty_network_boticario/controllers/register_controller.dart';
import 'package:beauty_network_boticario/viewmodels/register_view_model.dart';
import 'package:beauty_network_boticario/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  RegisterView(this._registerController);

  final RegisterControllerInterface _registerController;

  final RegisterViewModel _userModel = new RegisterViewModel();
  static final _registerFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(119, 149, 128, 1),
      appBar: CustomAppBarWidget(
        title: 'Cadastre-se',
      ),
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        child: Form(
          key: _registerFormKey,
          child: SafeArea(
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
                        if (_registerFormKey.currentState.validate()) {
                          _registerFormKey.currentState.save();
                          print(_userModel);
                          _registerController.register(_userModel);
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
    );
  }
}
