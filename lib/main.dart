import 'package:est/screens/login_screen.dart';
import 'package:est/screens/Home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:est/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estate',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthWrapper(),
        '/home': (context) => HomeScreen(),
        // Add other routes if needed
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
