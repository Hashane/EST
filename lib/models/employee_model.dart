class Employee {
  final int employeeID;
  final String name;
  final int phone;
  final int bankAccountNo;
  final String type;
  final String position;

  Employee({required this.employeeID,
    required this.name,
    required this.phone,
    required this.bankAccountNo,
    required this.type,
    required this.position
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeID: json['employeeID'],
      name: json['name'],
      phone: json['phone'],
      bankAccountNo: json['bankAccountNo'],
      type: json['type'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeID': employeeID,
      'name': name,
      'phone': phone,
      'bankAccountNo': bankAccountNo,
      'type': type,
      'position': position,
    };
  }
}