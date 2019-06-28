import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  bool horizontal = false;

  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,]); // Bloquear la orientación de la pantalla a horizontal y sin invertir.
    auth.getUser.then((user) {
      if(user != null) {
        // Si se ha iniciado sesión deberemos detectar si el usuario es ADMIN, EDITOR, JUEZMESA o JUEZSILLA.
        // Si es la primera vez que se inicia sesión con ese usuario de Firebase se deberá generar el documento correspondiente en la colección USUARIOS de la BD.
        // Esto se hace con el método updateUserData de la clase auth. (services/auth.dart)
        Navigator.pushReplacementNamed(context, '/perfil');
      } else { // User == null
        LoadingScreen();
      }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    horizontal = checkScreenSize();
    //print('horizontal --> ' + horizontal.toString());
    if(!horizontal) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]); // Bloquear la orientación de la pantalla a vertical y sin invertir.
      return Scaffold( // Layout Vertical
        body: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlutterLogo(size: 50,),
                Image.asset(
                  'assets/icons/logo_app1.png', width: 150, height: 150,),
                Text(
                  'AppArbitraje',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Iniciar Sesión',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead,
                  textAlign: TextAlign.center,
                ),
                LoginButton(
                  text: 'Usar GOOGLE',
                  icon: FontAwesomeIcons.google,
                  color: Colors.black45,
                  loginMethod: auth.googleSignIn,
                ),
                LoginButton(
                  text: 'Seguir como Invitado',
                  loginMethod: auth.anonLogin,
                ),
              ],
          ),
        ),
      );
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,]); // Bloquear la orientación de la pantalla a horizontal y sin invertir.
      final columnaIzda = new Container(
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlutterLogo(size: 50,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/icons/logo_app1.png', width: 150, height: 150,),
              ),
              Text(
                'AppArbitraje',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
      final columnaDcha = new Container(
        child: Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Iniciar Sesión',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead,
                    textAlign: TextAlign.center,
                  ),
                ),
                LoginButton(
                  text: 'Usar GOOGLE',
                  icon: FontAwesomeIcons.google,
                  color: Colors.black45,
                  loginMethod: auth.googleSignIn,
                ),
                LoginButton(
                  text: 'Seguir como Invitado',
                  loginMethod: auth.anonLogin,
                )
              ],
            ),
          ),
        ),
      );

      return Scaffold( // Layout Horizontal
        body: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              columnaIzda,
              columnaDcha,
            ],
          ),
        ),
      );
    }
  }

  // Modificación para tablet y web
  // Login con Layout horizontal
  bool checkScreenSize(){
    bool res = false;
    if(MediaQuery.of(context).size.width < 500) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]); // Bloquear la orientación de la pantalla a vertical y sin invertir.
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,]); // Bloquear la orientación de la pantalla a horiznotal y sin invertir.
      res = true;
    }
    return res;
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({
    Key key, this.text, this.icon, this.color, this.loginMethod
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
          padding: EdgeInsets.all(30),
          icon: Icon(icon, color: Colors.white),
          color: color,
          onPressed: () async {
            var user = await loginMethod();
            if (user != null) {
              Navigator.pushReplacementNamed(context, '/perfil');
            }
          },
      label: Expanded(
          child: Text('$text', textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
