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
}
