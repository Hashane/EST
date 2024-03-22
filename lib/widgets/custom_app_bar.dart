import 'package:flutter/material.dart';
import 'package:est/themes/theme.dart';
import 'package:est/screens/login_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  CustomAppBar({required this.titleText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        titleText,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app), // Example of an action icon
          onPressed: () {
            // Add your action handling here, for example logout functionality
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to login screen
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
