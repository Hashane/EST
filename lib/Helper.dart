import 'package:cloud_firestore/cloud_firestore.dart';

class Helper {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getExpenses(
      String type, {
        String? startDate,
        String? endDate,
      }) {
    CollectionReference<Map<String, dynamic>> expensesCollection =
    FirebaseFirestore.instance.collection(type);

    // Convert string dates back to DateTime objects
    DateTime? startDateTime = startDate != null ? DateTime.parse(startDate) : null;
    DateTime? endDateTime = endDate != null ? DateTime.parse(endDate) : null;

    // Constructing the query
    Query<Map<String, dynamic>> query = expensesCollection;

    // Filter by start date if provided
    if (startDate != null) {
      query = query.where('expenseDate', isGreaterThanOrEqualTo: startDate);
    }

    // Filter by end date if provided
    if (endDate != null) {
      query = query.where('expenseDate', isLessThanOrEqualTo: endDate);
    }

    // Return the stream of query snapshots
    return query.snapshots();
  }

  static Future<void> addToFirestoreAndUpdateTotal(String collectionName, Map<String, dynamic> expenseData, double price) async {
    try {
      // Get Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add to Firestore
      DocumentReference docRef = await firestore.collection(collectionName).add(expenseData);

      // Update the total expense
      await updateTotalExpense(collectionName,price);

      print('Expense added to Firestore successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Error adding expense to Firestore: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }

  /**
   * This method is used to keep track of total
   * of each expense category
   */
  static Future<void> updateTotalExpense(String collectionName, double newExpenseAmount) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference expenseTotalRef = firestore.collection('totalExpenses');
      DocumentReference totalRef = expenseTotalRef.doc(collectionName);

      // Get current total expense
      DocumentSnapshot totalSnapshot = await totalRef.get();
      double currentTotal = totalSnapshot.exists ?
      double.tryParse((totalSnapshot.data() as Map<String, dynamic>)['total'].toString()) ?? 0.0 :
      0.0;

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
}
