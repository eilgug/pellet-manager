import 'package:flutter/material.dart';

class MyBottomAppBar extends StatefulWidget {
  final Function(int) onTap;
  const MyBottomAppBar({Key? key, required this.onTap}) : super(key: key);

  @override
  State<MyBottomAppBar> createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 4,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.euro),
          label: 'Spese',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.location_on), label: 'Fornitori'),
        BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'Altro'),
      ],
      unselectedItemColor: Colors.grey.shade900,
      selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      showUnselectedLabels: true,
      selectedFontSize: 12,
    );
  }
}
