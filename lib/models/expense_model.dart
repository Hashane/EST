import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final int expenseID;
  final DateTime expenseDate;
  final String name;
  final double amount;
  final String category;
  final int? treeID; // Nullable
  final int? salaryPaymentID;

  Expense({
    required this.expenseID,
    required this.expenseDate,
    required this.amount,
    required this.category,
    required this.name,
    this.treeID,
    this.salaryPaymentID,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      expenseID: json['expenseID'],
      expenseDate: DateTime.parse(json['expenseDate']),
      name: json['name'],
      amount: json['amount'].toDouble(),
      category: json['category'],
      treeID: json['treeID'],
      salaryPaymentID: json['salaryPaymentID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenseID': expenseID,
      'expenseDate': expenseDate.toIso8601String(),
      'name': name,
      'amount': amount,
      'category': category,
      'treeID': treeID,
      'salaryPaymentID': salaryPaymentID,
    };
  }

  Future<void> addToFirestore(String collectionName) async {
    try {
      // Get Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Convert Expense object to JSON
      Map<String, dynamic> expenseData = toJson();

      // Add to Firestore
      await firestore.collection(collectionName).add(expenseData);

      // Update the total expense
      await updateTotalExpense(expenseData['amount']);

      print('Expense added to Firestore successfully!');
    } catch (e) {
      print('Error adding expense to Firestore: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }

  /**
   * This method is used to keep track of total
   * of each expense category
   *
   */
  Future<void> updateTotalExpense(double newExpenseAmount) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference expenseTotalRef = firestore.collection('totalExpenses');
      DocumentReference totalRef = expenseTotalRef.doc('treeExpensesTotal');

      // Get current total expense
      DocumentSnapshot totalSnapshot = await totalRef.get();
      double currentTotal = totalSnapshot.exists ? (totalSnapshot.data() as Map<String, dynamic>)['total'] ?? 0.0 : 0.0;

      // Update total
      double updatedTotal = currentTotal + newExpenseAmount;

      // Save updated total
      await totalRef.set({'total': updatedTotal});

      print('Total expense updated successfully!');
    } catch (e) {
      print('Error updating total expense: $e');
      throw e;
    }
  }

   static Future<void> deleteExpenseFromFirestore(int expenseID) async {
    try {
      // Get Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query for the document with the specified expenseID
      QuerySnapshot snapshot = await firestore.collection('treeExpenses').where('expenseID', isEqualTo: expenseID).get();

      // Check if the snapshot contains any documents
      if (snapshot.docs.isNotEmpty) {
        // Get the document reference and delete it
        await snapshot.docs.first.reference.delete();
      } else {
        print('Document with expenseID $expenseID not found.');
      }
      print('Expense deleted successfully from Firestore');
    } catch (e) {
      print('Error deleting expense from Firestore: $e');
      throw e;
    }
  }
}
