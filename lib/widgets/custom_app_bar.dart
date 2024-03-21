import 'package:flutter/material.dart';
import 'package:est/themes/theme.dart';
import 'package:est/screens/login_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  CustomAppBar({required this.titleText});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomTheme.primaryColor,
      title: Text(
            titleText,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.notifications_sharp),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }
}
