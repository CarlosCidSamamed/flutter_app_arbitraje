import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]); // Bloquear la orientación de la pantalla a vertical y sin invertir.

    if(user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple, 
          title: Text(user.displayName ?? 'Anónimo'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(user.photoUrl != null)
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(user.photoUrl)),
                    ),
                  ),
                Text(user.email ?? '', style: Theme.of(context).textTheme.headline),
                Spacer(),
                FlatButton(
                  child: Text('Cerrar Sesión'),
                  color: Colors.blueGrey,
                  onPressed: () async {
                    await auth.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
                Spacer(),
              ],
            ),
          ),
      );
    } else {
      return LoadingScreen();
    }   
  }
}