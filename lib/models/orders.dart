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

  double get amountPerBag {
    return totalAmount / bags;
  }
}
