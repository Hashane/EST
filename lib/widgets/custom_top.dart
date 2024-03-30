import 'package:flutter/material.dart';
import 'package:est/themes/theme.dart';
import 'package:est/screens/authentication/login_screen.dart';

class CustomBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2, // Adjust the height as needed
          decoration: BoxDecoration(
            color: CustomTheme.primaryColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.1 - 60,
          left: 15,
          right: 15,
          child: SizedBox(
            height: 200, // Adjust the height as desired
            child: Card(
              color: CustomTheme.primaryDarkColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
