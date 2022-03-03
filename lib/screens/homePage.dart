import 'package:flutter/material.dart';
import '../core/utils.dart';
import '../models/loads.dart';
import '../widgets/consumoMedio.dart';
import '../widgets/loadList.dart';
import '../widgets/sacchiRimanenti.dart';

class HomePage extends StatelessWidget {
  final int stock;
  final double average;
  final List<Loads> userLoads;
  final Function deleteLoad;
  final Function addNewLoad;
  final Function addNewOrder;

  const HomePage(
      {Key? key,
      required this.stock,
      required this.average,
      required this.userLoads,
      required this.deleteLoad,
      required this.addNewLoad,
      required this.addNewOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SacchiRimanenti(
                stock: stock,
                average: average,
                newOrder: () => startAddNewOrder(context, stock, addNewOrder)),
            ConsumoMedio(
                average: average,
                newLoad: () => startAddNewLoads(context, stock, addNewLoad)),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          margin: const EdgeInsets.only(left: 8, bottom: 4),
          child: const Text(
            "STORICO DEI CARICHI",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        LoadsList(
          userLoads: userLoads.reversed.toList(),
          deleteLoad: deleteLoad,
          average: average,
        )
      ],
    );
  }
}
