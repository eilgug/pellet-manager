import 'package:flutter/material.dart';
import 'package:pellet_manager/models/orders.dart';
import 'package:pellet_manager/widgets/autonomia.dart';
import 'package:pellet_manager/widgets/newOrder.dart';
import 'package:pellet_manager/widgets/orderList.dart';
import 'package:pellet_manager/widgets/sacchiRimanenti.dart';

import '../core/utils.dart';

class SpesePage extends StatelessWidget {
  final int stock;
  final double average;
  final Function addNewOrder;
  final Function deleteOrder;
  final List<Orders> userOrders;

  const SpesePage(
      {Key? key,
      required this.stock,
      required this.average,
      required this.addNewOrder,
      required this.userOrders,
      required this.deleteOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: [
          SacchiRimanenti(
            stock: stock,
            average: average,
            newOrder: () => startAddNewOrder(context, stock, addNewOrder),
          ),
          Autonomia(
            ggRestanti: stock / average,
          ),
        ]),
        const SizedBox(
          height: 16,
        ),
        Container(
          margin: const EdgeInsets.only(left: 8, bottom: 4),
          child: const Text(
            "STORICO DEGLI ORDINI",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        OrderList(userOrders: userOrders, deleteOrder: deleteOrder)
      ],
    );
  }
}
