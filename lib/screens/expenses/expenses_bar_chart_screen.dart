import 'package:flutter/material.dart';
import 'package:est/screens/expenses/expenses_list_screen.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<double> expenses;
  final List<String> categories;

  HorizontalBarChart({required this.expenses, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExpensesListScreen(),
          ),
        );
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            expenses.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(categories[index]),
                    SizedBox(width: 10),
                    Container(
                      height: 30, // Fixed height for the bars
                      width: expenses[index] /
                          500, // Adjusted based on expense value
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('${expenses[index]}'),
                    SizedBox(height: 50),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
