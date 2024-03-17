import 'package:est/models/app_user.dart';
import 'package:est/screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:est/common_errors.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Assuming you have form fields for email and password
  void _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    AppUser.login(email, password).then((user) {
      // Check for the AppUser object first
      if (user != null) {
        // Login was successful
        // Access user.email and user.uid as needed
        String userEmail = user.email!;
        String userId = user.uid!;

         if (ModalRoute.of(context)?.settings.name != HomeScreen.routeName) {
           // Navigate to HomeScreen if it's not already on top of the stack
           Navigator.pushNamedAndRemoveUntil(
               context, HomeScreen.routeName, (route) => false);
         }
      }
    }).catchError((error) {
      // Handle the exception and show the exact error message to the user
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Error'),
            content: Text(error.toString()), // Display the exact error message
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400.0, // Set a maximum width for the form
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0), // Add some spacing
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0), // Add some spacing
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, // Hide the password
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0), // Add some spacing
                ElevatedButton(
                  onPressed: () => _login(context),
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


