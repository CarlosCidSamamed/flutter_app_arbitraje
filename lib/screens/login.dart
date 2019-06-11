import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared/shared.dart';
import '../services/services.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then((user) {
      if(user != null) {
        Navigator.pushReplacementNamed(context, '/inicio');
      }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlutterLogo(size: 150,),
            Text(
              'Iniciar Sesión',
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            ),
            //Text()
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
          ]
        ),
      ),
    );
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
              Navigator.pushReplacementNamed(context, '/inicio');
            }
          },
      label: Expanded(
          child: Text('$text', textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}