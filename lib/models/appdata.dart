import 'orders.dart';
import 'loads.dart';

class AppData {
  int stock;
  double average;
  List<Loads> userLoads;
  List<Orders> userOrders;

  AppData(
      {required this.stock,
      required this.average,
      required this.userLoads,
      required this.userOrders});

  AppData.fromJson(Map<String, dynamic> map)
      : stock = (map['stock'] as num).toInt(),
        average = (map['average'] as num).toDouble(),
        userLoads = (map['userLoads'] as List)
            .map((load) => Loads.fromJson(load))
            .toList(),
        userOrders = (map['userOrders'] as List)
            .map((order) => Orders.fromJson(order))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'stock': stock,
      'average': average,
      'userLoads': userLoads.map((e) => e.toJson()).toList(),
      'userOrders': userOrders.map((e) => e.toJson()).toList()
    };
  }
}
