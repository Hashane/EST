import 'package:flutter/material.dart';
import 'package:est/widgets/common_screen.dart';
import 'package:est/screens/trees/trees_add_screen.dart';

class TreesScreen extends StatefulWidget {
  @override
  _TreesScreenState createState() => _TreesScreenState();
}

class _TreesScreenState extends State<TreesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      title: 'Trees',
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Categories',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TreeCard('Coconut', Icons.energy_savings_leaf_rounded, 50),
              TreeCard('Mango', Icons.local_florist, 30),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TreeCard('Guava', Icons.eco, 20),
              TreeCard('Mango', Icons.local_florist, 30),
            ],
          ),
        ],
      ),
      onFABPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return TreesAddModalScreen();
          },
        );
      },
    );
  }
}

/// Represents a card displaying tree information.
class TreeCard extends StatelessWidget {
  final String treeName;
  final IconData icon;
  final int count;

  TreeCard(this.treeName, this.icon, this.count);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Container(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.green,
            ),
            Text(
              treeName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Count: $count',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

