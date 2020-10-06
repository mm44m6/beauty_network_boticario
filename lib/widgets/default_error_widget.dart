import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color_theme_swatch.dart';

class DefaultErrorWidget extends StatelessWidget {
  final scaffoldKey;
  final String error;

  DefaultErrorWidget({this.scaffoldKey, this.error});

  @override
  Widget build(BuildContext context) {
    _snackBarError() {
      var snackbar = SnackBar(
        backgroundColor: Theme.of(context).accentColor,
        content: Text(
          "$error",
          style: TextStyle(color: ColorThemeSwatch.boticarioWhite),
        ),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }

    _dialogError() {
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

    return Platform.isAndroid ? _dialogError() : _snackBarError();
  }
}
