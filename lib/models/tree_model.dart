class Trees {
  final int treeID;
  final String type;
  final DateTime plantedDate;
  final int count;

  Trees({
    required this.treeID,
    required this.type,
    required this.plantedDate,
    required this.count
  });

  factory Trees.fromJson(Map<String, dynamic> json) {
    return Trees(
      treeID: json['treeID'],
      type: json['type'],
      plantedDate: json['plantedDate'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'treeID': treeID,
      'type': type,
      'plantedDate': plantedDate,
      'count': count,
    };
  }
}