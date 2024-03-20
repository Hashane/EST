import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:est/models/expense_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add an expense to Firestore
  Future<void> addExpense(Expense expense) async {
    try {
      // Convert the expense object to a map
      Map<String, dynamic> expenseData = expense.toJson();

      // Add the expense data to the 'expenses' collection in Firestore
      await FirebaseFirestore.instance.collection('expenses').add(expenseData);

      print('Expense added to Firestore');
    } catch (error) {
      print('Error adding expense to Firestore: $error');
      // Handle any errors that occur during the process
    }
  }
}
