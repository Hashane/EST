import 'package:flutter/material.dart';
import 'package:est/themes/theme.dart';
import 'package:est/screens/login_screen.dart';
import 'package:est/screens/expenses_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int activeDay = 3;
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.themeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: const TextStyle(color: Colors.white), // Set app bar text color to white
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
          automaticallyImplyLeading: false, // Remove the default leading widget (back button)
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: CustomTheme.primaryColor, // Set background color to red
              child: const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  'Hello, User!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ),
            ),
            getBody(),
          ],
        ),
      ),
    );
  }


  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 100,
          decoration: const BoxDecoration(
            color: CustomTheme.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(80),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: CustomTheme.primaryDarkColor, // Use CustomTheme.primaryColor
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3,
                  // changes position of shadow
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Net balance",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.white, // Assuming you want white text on the colored background
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\$35000.90",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white, // Assuming you want white text on the colored background
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
