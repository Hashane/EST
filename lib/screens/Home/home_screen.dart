import 'package:est/models/app_user.dart';
import 'package:est/screens/Home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:est/screens/trees/trees_screens.dart';
import 'package:est/screens/employees/employees_screen.dart';
import 'package:est/screens/tools/tools_screen.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTabTapped(int index) {
    if (_currentIndex == index) {
      // Pop to the initial route of the current tab's Navigator
      _navigatorKeys[index]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Widget _buildNavigator(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              switch (index) {
                case 0:
                  return Dashboard();
                case 1:
                  return TreesScreen();
                case 2:
                  return ToolsScreen();
                case 3:
                  return EmployeesScreen();
                default:
                  return Container();
              }
            },
            // Set the transition duration to zero for instant transitions.
            transitionDuration: const Duration(seconds: 0),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildNavigator(0),
          _buildNavigator(1),
          _buildNavigator(2),
          _buildNavigator(3),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          const BottomNavigationBarItem(
            icon:  Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon:  Icon(Icons.eco),
            label: 'Trees',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.engineering),
            label: 'Workers',
          ),
        ],
      ),
    );
  }
}
