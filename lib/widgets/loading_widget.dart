import 'package:beauty_network_boticario/color_theme_swatch.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool busy;
  final Widget child;

  LoadingWidget({this.busy, this.child});

  @override
  Widget build(BuildContext context) {
    return busy
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: ColorThemeSwatch.boticarioLightPink,
              ),
            ),
          )
        : child;
  }
}
