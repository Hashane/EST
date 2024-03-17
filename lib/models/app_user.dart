import 'package:firebase_auth/firebase_auth.dart';

class AppUser{
  String? uid;
  String? email;

  AppUser({this.uid, this.email});

  // Register a new user with email and password
  static Future<AppUser?> register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUser(uid: userCredential.user?.uid, email: userCredential.user?.email);
    } catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }


  // Log in an existing user with email and password
  static Future<AppUser?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUser(uid: userCredential.user?.uid, email: userCredential.user?.email);
    } catch (e) {
      print(e);
      if (e is FirebaseAuthException) {
        throw Exception(mapFirebaseErrorToMessage(e.code));
      } else {
        throw Exception("An unknown error occurred during login.");
      }
    }
  }


  static String mapFirebaseErrorToMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return "User not found. Please check your email.";
      case "too-many-requests":
        return "Access to this account has been temporarily disabled due to many failed login attempts.";
      case "invalid-email":
        return "Invalid email address. Please enter a valid email.";
      case "invalid-credential":
        return "Invalid credentials. Please try again later.";
      default:
        return "An error occurred during login. Please try again later.";
    }
  }

  // Log out the current user
  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
