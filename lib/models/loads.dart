class Loads {
  final String id; // unique
  final int bags;
  final DateTime date;

  Loads({required this.id, required this.bags, required this.date});

  Loads.fromJson(Map<String, dynamic> map)
      : id = map['id'] as String,
        bags = (map['bags'] as num).toInt(),
        date = DateTime.parse(map['date'].toString());

  Map<String, dynamic> toJson() {
    return {'id': id, 'bags': bags, 'date': date.toString()};
  }
}
