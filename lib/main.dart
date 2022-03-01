import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pellet_manager/screens/aboutPage.dart';
import 'package:pellet_manager/screens/fornitoriPage.dart';
import 'package:pellet_manager/screens/homePage.dart';
import 'package:pellet_manager/screens/spesePage.dart';
import 'package:pellet_manager/widgets/myBottomAppBar.dart';

import 'widgets/newLoad.dart';

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
  final List<Widget> _pages = [
    HomePage(),
    SpesePage(),
    FornitoriPage(),
    AboutPage()
  ];

  void _navigate(int index) {
    setState(() {
      _selectedIndex = index;
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
      bottomNavigationBar: MyBottomAppBar(onTap: _navigate),
      body: _pages[_selectedIndex],
    );
  }
}
