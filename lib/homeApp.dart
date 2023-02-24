import 'package:flutter/material.dart';
import 'dashboardPage.dart';
import 'lockPage.dart';
import 'usersPage.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();


  }



class _HomeAppState extends State<HomeApp> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
      Dashboard(),
      Lock(),
      Users()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Pressed ${index}');
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.data_usage),
              label: 'Dashboard'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'Lock'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Users'
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
  }
