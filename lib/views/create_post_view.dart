import 'package:beauty_network_boticario/color_theme_swatch.dart';
import 'package:flutter/material.dart';

class CreatePostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                maxLines: 8,
                maxLength: 280,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black54),
                  counterStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: ColorThemeSwatch.boticarioLightGreen,
                        width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: ColorThemeSwatch.boticarioLightGreen,
                        width: 1.0),
                  ),
                  labelStyle: TextStyle(
                      color: ColorThemeSwatch.boticarioDarkGreen, fontSize: 20),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                        color: ColorThemeSwatch.boticarioLightGreen,
                        width: 1.0),
                  ),
                  focusColor: Colors.blue,
                  fillColor: Colors.blue,
                  hintText: "Compartilhe o que você está pensando!",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
