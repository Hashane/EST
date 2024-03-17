class Income {
  final int incomeID;
  final DateTime incomeDate;
  final double amount;
  final int treeID;

  Income({required this.incomeID, required this.incomeDate, required this.amount, required this.treeID});

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      incomeID: json['incomeID'],
      incomeDate: DateTime.parse(json['incomeDate']),
      amount: json['amount'].toDouble(),
      treeID: json['treeID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'incomeID': incomeID,
      'incomeDate': incomeDate.toIso8601String(),
      'amount': amount,
      'treeID': treeID,
    };
  }
}