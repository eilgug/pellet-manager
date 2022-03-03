import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pellet_manager/models/orders.dart';

class OrderList extends StatelessWidget {
  final List<Orders> userOrders;
  final Function deleteOrder;
  //final double average;

  const OrderList({
    Key? key,
    required this.userOrders,
    required this.deleteOrder,
    //required this.average
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: userOrders.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fireplace_outlined,
                  size: 70,
                  color: Colors.amber.shade600,
                ),
                const Text(
                  'Aggiungi un carico per cominciare',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ))
          : ListView.builder(
              itemCount: userOrders.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        '${userOrders[index].totalAmount}€',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('Sacchi: ${userOrders[index].bags}'),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy').format(userOrders[index].date),
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline,
                          color: Theme.of(context).errorColor),
                      onPressed: () => deleteOrder(userOrders[index].id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
