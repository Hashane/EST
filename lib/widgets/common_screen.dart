import 'package:flutter/material.dart';
import 'package:est/widgets/custom_app_bar.dart';
import 'package:est/themes/theme.dart';

class CommonScreen extends StatefulWidget {
  final String title;
  final Widget body;
  final Function()? onFABPressed;
  final bool showBackButton;
  final bool showFAB;
  CommonScreen({required this.title, required this.body, this.onFABPressed, this.showBackButton = false,this.showFAB = true});

  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomTheme.primaryColor,
      appBar: CustomAppBar(titleText: widget.title,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: CustomTheme.primaryColor,
            ),
          ),
          Expanded(
            flex: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: widget.body,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: widget.showFAB
          ? FloatingActionButton(
        onPressed: widget.onFABPressed,
        child: Icon(Icons.add),
      )
          : null,
    );
  }
}