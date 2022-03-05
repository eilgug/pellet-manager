import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pellet_manager/core/filehandler.dart';
import 'package:pellet_manager/models/appdata.dart';
import 'package:pellet_manager/screens/aboutPage.dart';
import 'package:pellet_manager/screens/fornitoriPage.dart';
import 'package:pellet_manager/screens/homePage.dart';
import 'package:pellet_manager/screens/spesePage.dart';
import 'package:pellet_manager/screens/welcomeScreen.dart';
import 'package:pellet_manager/widgets/myBottomAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils.dart';
import 'models/loads.dart';
import 'models/orders.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PelletManager',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home:
          MyHomePage(title: 'PelletManager', fileHandler: FileHandler.instance),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.fileHandler})
      : super(key: key);

  final FileHandler fileHandler;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _firstTime = true;

  AppData appData =
      AppData(stock: 0, average: 0, userLoads: [], userOrders: []);

  @override
  @protected
  @mustCallSuper
  void initState() {
    super.initState();

    checkFirstOpen();

    widget.fileHandler.readAppData().then((AppData value) {
      setState(() {
        appData = value;
        FlutterNativeSplash.remove();
      });
    });
  }

  Widget _getPages(int index) {
    switch (index) {
      case 0:
        return HomePage(
            stock: appData.stock,
            average: appData.average,
            userLoads: appData.userLoads,
            deleteLoad: _deleteLoad,
            addNewLoad: _addNewLoads,
            addNewOrder: _addNewOrder);
      case 1:
        return SpesePage(
          stock: appData.stock,
          average: appData.average,
          userOrders: appData.userOrders,
          addNewOrder: _addNewOrder,
          deleteOrder: _deleteOrder,
        );
      case 2:
        return const FornitoriPage();
      case 3:
        return const AboutPage();
      case 4:
        return WelcomeScreen(firstSetUp: _firstSetup);
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
      appData.stock -= newLoad.bags;
      appData.average =
          ((appData.average * appData.userLoads.length) + newLoad.bags) /
              (appData.userLoads.length + 1);

      appData.userLoads.add(newLoad);
      orderByDate(appData.userLoads);
      widget.fileHandler.writeAppData(appData);
    });
  }

  void _addNewOrder(int bags, DateTime date, int totalAmount) {
    final Orders newOrder = Orders(
        id: DateTime.now().toString(),
        bags: bags,
        date: date,
        totalAmount: totalAmount);

    setState(() {
      appData.stock += bags;
      appData.userOrders.add(newOrder);
      widget.fileHandler.writeAppData(appData);
    });
  }

  void _deleteLoad(String id) {
    setState(() {
      Loads loadToBeRemoved =
          appData.userLoads.firstWhere((load) => load.id == id);

      appData.stock += loadToBeRemoved.bags;
      appData.average = ((appData.average * appData.userLoads.length) -
              loadToBeRemoved.bags) /
          (appData.userLoads.length - 1);
      if (appData.average.isNaN) {
        appData.average = 0.0;
      }

      appData.userLoads.remove(loadToBeRemoved);
      widget.fileHandler.writeAppData(appData);
    });
  }

  void _deleteOrder(String id) {
    setState(() {
      Orders orderToBeRemoved =
          appData.userOrders.firstWhere((order) => order.id == id);

      appData.stock -= orderToBeRemoved.bags;
      appData.userOrders.remove(orderToBeRemoved);
      widget.fileHandler.writeAppData(appData);
    });
  }

  Future checkFirstOpen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _firstCheck = (preferences.getBool('firstTime') ?? true);

    if (_firstCheck) {
      await preferences.setBool('firstTime', false);
      _navigate(4);
    } else {
      _firstTime = false;
      _navigate(0);
    }
  }

  void _firstSetup(int bags) {
    setState(() {
      appData.stock += bags;
      widget.fileHandler.writeAppData(appData);
      _firstTime = false;
      _navigate(0);
    });
  }

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
      bottomNavigationBar: Visibility(
          visible: !_firstTime, child: MyBottomAppBar(onTap: _navigate)),
      body: _getPages(_selectedIndex),
    );
  }
}
