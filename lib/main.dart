import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pellet_manager/screens/aboutPage.dart';
import 'package:pellet_manager/screens/fornitoriPage.dart';
import 'package:pellet_manager/screens/homePage.dart';
import 'package:pellet_manager/screens/spesePage.dart';
import 'package:pellet_manager/widgets/myBottomAppBar.dart';

import 'core/utils.dart';
import 'models/loads.dart';
import 'models/orders.dart';

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
  int _selectedIndex = 0;

  int _stock = 90;
  double _average = 0.0;
  final List<Loads> _userLoads = [];
  final List<Orders> _userOrders = [];

  Widget _getPages(int index) {
    switch (index) {
      case 0:
        return HomePage(
            stock: _stock,
            average: _average,
            userLoads: _userLoads,
            deleteLoad: _deleteLoad,
            addNewLoad: _addNewLoads,
            addNewOrder: _addNewOrder);
      case 1:
        return const SpesePage();
      case 2:
        return const FornitoriPage();
      case 3:
        return const AboutPage();
      default:
        return const Text('Ops, qualcosa è andato storto!');
    }
  }

  void _navigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addNewLoads(int bags, DateTime date) {
    final Loads newLoad =
        Loads(id: DateTime.now().toString(), bags: bags, date: date);

    setState(() {
      _stock -= newLoad.bags;
      _average = ((_average * _userLoads.length) + newLoad.bags) /
          (_userLoads.length + 1);

      _userLoads.add(newLoad);
      orderByDate(_userLoads);
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

      _stock += loadToBeRemoved.bags;
      _average = ((_average * _userLoads.length) - loadToBeRemoved.bags) /
          (_userLoads.length - 1);
      if (_average.isNaN) {
        _average = 0.0;
      }

      _userLoads.remove(loadToBeRemoved);
    });
  }

  // TODO: _deleteOrder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.pacifico(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: MyBottomAppBar(onTap: _navigate),
      body: _getPages(_selectedIndex),
    );
  }
}
