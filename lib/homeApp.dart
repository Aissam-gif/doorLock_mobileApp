import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/pages/settingsPage.dart';
import 'package:iot_project/theme/colors.dart';
import 'pages/dashboardPage.dart';
import 'pages/lockPage.dart';
import 'pages/usersPage.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';



class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();


  }



class _HomeAppState extends State<HomeApp> {
  int selectedPage = 0;
  static const List<Widget> pages = <Widget>[
      DashboardPage(),
      LockPage(),
      UsersPage(),
      SettingsPage()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedPage = index;
      print('Pressed ${index}');
    });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: getBody(),
      bottomNavigationBar: getFooter(),
      floatingActionButton: SafeArea(
        child: SizedBox(
          // height: 30,
          // width: 40,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(context: context,
                  builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          //TODO: Save the user to the database
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Add User"
                        ))
                  ],
                    scrollable: true,
                    title: Text('Add New User'),
                    content:
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                    child: Column(
                    children: <Widget>[
                    TextFormField(
                    decoration: InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.account_box),
                    ),
                    ),
                    TextFormField(
                    decoration: InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.password),
                    ),
                    ),
                    ],
                    ),
                    ),
                )
                );
                  });
            },
            child: Icon(
              Icons.add,
              size: 20,
            ),
            backgroundColor: buttoncolor,
            // shape:
            //     BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: selectedPage,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      CupertinoIcons.home,
      CupertinoIcons.lock,
      CupertinoIcons.person,
      CupertinoIcons.settings,
    ];
    return AnimatedBottomNavigationBar(
        backgroundColor: primary,
        icons: iconItems,
        splashColor: secondary,
        inactiveColor: black.withOpacity(0.5),
        gapLocation: GapLocation.center,
        activeIndex: selectedPage,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        iconSize: 25,
        rightCornerRadius: 10,
        elevation: 2,
        onTap: (index) {
          onItemTapped(index);
        });
  }


  }



