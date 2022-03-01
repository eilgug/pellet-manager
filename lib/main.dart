import 'package:flutter/material.dart';
import 'package:pellet_manager/models/loads.dart';
import 'package:pellet_manager/widgets/consumoMedio.dart';
import 'package:pellet_manager/widgets/loadList.dart';
import 'package:pellet_manager/widgets/myBottomAppBar.dart';
import 'package:pellet_manager/widgets/sacchiRimanenti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pellet Manager',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Pellet Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _stock = 90;
  double _average = 0.0;
  final List<Loads> _userLoads = [
    //Loads(id: DateTime.now().toString(), bags: 4, date: DateTime.now()),
    //Loads(id: DateTime.now().toString(), bags: 4, date: DateTime.now()),
  ];

  void _addNewLoads(int bags, DateTime date) {
    final Loads newLoad =
        Loads(id: DateTime.now().toString(), bags: bags, date: date);

    setState(() {
      _stock -= newLoad.bags;
      _average = ((_average * _userLoads.length) + newLoad.bags) /
          (_userLoads.length + 1);

      _userLoads.add(newLoad);
      _orderBy(1);
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

  void _orderBy(int by) {
    _userLoads.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: MyBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewLoads(6, DateTime.now()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Grafico carici giornalieri
          Container(
            width: double.infinity,
            child: Card(
              child: Text('GRAFICO'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SacchiRimanenti(stock: _stock),
              ConsumoMedio(average: _average),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.only(left: 8, bottom: 4),
            child: Text(
              "LISTA DEI CARICHI",
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
          )
        ],
      ),
    );
  }
}
