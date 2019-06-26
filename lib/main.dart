import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/services.dart';
import 'screens/screens.dart';
import 'shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp],);
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(stream: AuthService().user),
      ],
      child: MaterialApp(
        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],

        // Named Routes
        routes: {
          '/': (context) => LoginScreen(),
          '/inicio': (context) => HomeScreen(),
          '/perfil': (context) => ProfileScreen(),
          '/admin': (context) => AdminScreen(),
          //'/editor': (context) => EditorScreen(),
          //'/mesa': (context) => MesaScreen(),
          //'/silla': (context) => SillaScreen(),
          //'/visitante': (context) => VisitanteScreen(),
          '/acerca': (context) => AboutScreen(),
          // Listados ADMIN
          '/listados': (context) => AdminListHubScreen(),
          //'/listados/usuarios': (context) => UsuariosListScreen(),
          '/listados/usuarios': (context) => FiltroUsuarios(),
          '/prueba2Col': (context) => SelectLayout(tit: "Prueba",),
        },

        // Theme
        theme: ThemeData(
          fontFamily: 'Nunito',
          appBarTheme: AppBarTheme(
              color: Colors.deepPurple
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.black87,
          ),
          brightness: Brightness.dark,
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 18),
            body2: TextStyle(fontSize: 16),
            button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
            headline: TextStyle(fontWeight: FontWeight.bold),
            subhead: TextStyle(color: Colors.grey),
          ),
          //buttonTheme: ButtomThemeData()
        ),
      ),
    );
  }
}
