import 'package:flutter/material.dart';

void showCommonErrorSnackbar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      duration: Duration(seconds: 3), // Adjust the duration as needed
    ),
  );
}
