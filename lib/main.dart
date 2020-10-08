import 'package:beauty_network_boticario/color_theme_swatch.dart';
import 'package:beauty_network_boticario/controllers/login_controller.dart';
import 'package:beauty_network_boticario/repository/account_repository.dart';
import 'package:beauty_network_boticario/stores/user_store.dart';
import 'package:beauty_network_boticario/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Text('${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<UserStore>(create: (_) => UserStore()),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: GoogleFonts.davidLibreTextTheme(
                  Theme.of(context).textTheme,
                ),
                primarySwatch: ColorThemeSwatch.boticarioLightGreen,
                primaryColorDark: ColorThemeSwatch.boticarioDarkGreen,
                accentColor: ColorThemeSwatch.boticarioDarkPink,
                errorColor: ColorThemeSwatch.boticarioRed,
                hintColor: ColorThemeSwatch.boticarioWhite,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                buttonTheme: ButtonThemeData(
                  buttonColor: ColorThemeSwatch.boticarioDarkGreen,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                        color: ColorThemeSwatch.boticarioWhite, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                        color: ColorThemeSwatch.boticarioWhite, width: 2.0),
                  ),
                  labelStyle: TextStyle(
                      color: ColorThemeSwatch.boticarioWhite, fontSize: 20),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                        color: ColorThemeSwatch.boticarioWhite, width: 2.0),
                  ),
                ),
              ),
              home: LoginView(
                LoginController(
                  AccountRepository(),
                ),
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
