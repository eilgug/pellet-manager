class Orders {
  final String id; // unique
  final int bags;
  final int totalAmount;
  final DateTime date;

  Orders(
      {required this.id,
      required this.bags,
      required this.totalAmount,
      required this.date});

  Orders.fromJson(Map<String, dynamic> map)
      : id = map['id'] as String,
        bags = (map['bags'] as num).toInt(),
        totalAmount = (map['totalAmount'] as num).toInt(),
        date = DateTime.parse(map['date'].toString());

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bags': bags,
      'totalAmount': totalAmount,
      'date': date.toString()
    };
  }

  double get amountPerBag {
    return totalAmount / bags;
  }
}
