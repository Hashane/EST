import 'package:est/screens/login_screen.dart';
import 'package:est/screens/Home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:est/firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Check if the user is logged in
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user == null) {
      // If the user is not logged in, navigate to the login screen
      return MaterialApp(
        home: LoginScreen()
      );
    } else {
      // If the user is logged in, navigate to the home screen or any other screen
      return MaterialApp(
        home: HomeScreen(),
      );
    }
  }
}
