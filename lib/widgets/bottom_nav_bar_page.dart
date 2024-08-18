import 'package:demoapp/screens/home_page/home_page.dart';
import 'package:demoapp/screens/profile_page/pages/edit_page.dart';
import 'package:demoapp/screens/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentindex = 0;
  List<Widget> pagelist = [
    HomePage(),
    DisplayPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagelist[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              currentindex = value;
            });
          },
          currentIndex: currentindex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
              backgroundColor: Colors.indigo,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "profile",
              backgroundColor: Colors.indigo,
            )
          ]),
    );
  }
}
