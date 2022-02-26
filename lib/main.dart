import 'package:flutter/material.dart';
import 'package:pellet_manager/models/carichi.dart';
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
  final List<Loads> _userLoads = [
    Loads(id: DateTime.now().toString(), bags: 4, date: DateTime.now()),
    Loads(id: DateTime.now().toString(), bags: 4, date: DateTime.now()),
  ];

  void _addNewLoads(int bags, DateTime date) {
    final Loads newLoad =
        Loads(id: DateTime.now().toString(), bags: bags, date: date);

    setState(() {
      _userLoads.add(newLoad);
      _orderBy(1);
    });
  }

  void _orderBy(int by) {
    setState(() {
      _userLoads.sort((a, b) => a.date.compareTo(b.date));
    });
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
        onPressed: () => _orderBy(1),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
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
              SacchiRimanenti(),
              ConsumoMedio(),
            ],
          ),
          //Lista carichi
          LoadsList(userLoads: _userLoads.reversed.toList())
        ],
      ),
    );
  }
}
