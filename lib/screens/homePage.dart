import 'package:flutter/material.dart';
import 'package:pellet_manager/models/orders.dart';
import 'package:pellet_manager/widgets/newOrder.dart';

import '../models/loads.dart';
import '../widgets/consumoMedio.dart';
import '../widgets/loadList.dart';
import '../widgets/newLoad.dart';
import '../widgets/sacchiRimanenti.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _stock = 90;
  double _average = 0.0;
  final List<Loads> _userLoads = [];
  final List<Orders> _userOrders = [];
  void _addNewLoads(int bags, DateTime date) {
    final Loads newLoad =
        Loads(id: DateTime.now().toString(), bags: bags, date: date);

    setState(() {
      _stock -= newLoad.bags;
      _average = ((_average * _userLoads.length) + newLoad.bags) /
          (_userLoads.length + 1);

      _userLoads.add(newLoad);
      _orderByDate(_userLoads);
    });
  }

  void _addNewOrder(int bags, DateTime date, int totalAmount) {
    final Orders newOrder = Orders(
        id: DateTime.now().toString(),
        bags: bags,
        date: date,
        totalAmount: totalAmount);

    setState(() {
      _stock += bags;
      _userOrders.add(newOrder);
    });
  }

  void _deleteLoad(String id) {
    setState(() {
      Loads loadToBeRemoved = _userLoads.firstWhere((load) => load.id == id);

      _stock += loadToBeRemoved.bags; // Aggiorno lo stock
      _average = ((_average * _userLoads.length) - loadToBeRemoved.bags) /
          (_userLoads.length - 1); // Aggiorno la media
      if (_average.isNaN) {
        _average = 0.0;
      } // Verifico che la average sia un numero valido

      _userLoads.remove(loadToBeRemoved); // Rimuovo l'elemento dalla lista
    });
  }

  void _startAddNewLoads(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (bCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewLoad(stock: _stock, addLoad: _addNewLoads));
        });
  }

  void _startAddNewOrder(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (bCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewOrder(stock: _stock, addOrder: _addNewOrder));
        });
  }

  void _orderBy(int by) {
    _userLoads.sort((a, b) => a.date.compareTo(b.date));
  }

  void _orderByDate(List list) {
    list.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewLoads(context),
          child: const Icon(Icons.add),
          backgroundColor: Colors.white),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SacchiRimanenti(
                  stock: _stock,
                  average: _average,
                  newOrder: () => _startAddNewOrder(context)),
              ConsumoMedio(
                  average: _average, newLoad: () => _startAddNewLoads(context)),
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
          //Lista carichi
          LoadsList(
            userLoads: _userLoads.reversed.toList(),
            deleteLoad: _deleteLoad,
            average: _average,
          )
        ],
      ),
    );
  }
}
