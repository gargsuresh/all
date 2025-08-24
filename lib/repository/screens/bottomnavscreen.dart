import 'package:all/repository/screens/withdrawscreen.dart';
import 'package:flutter/material.dart';

import 'allbidscreen.dart';
import 'chatscreen.dart';
import 'historyscreen.dart';
import 'homescreen.dart';


class BottomNavscreen extends StatefulWidget {
  const BottomNavscreen({super.key});

  @override
  State<BottomNavscreen> createState() => _BottomNavscreenState();
}

class _BottomNavscreenState extends State<BottomNavscreen> {
  int currentIndex = 2;
  List<Widget> pages = [
    AllBidscreen(),
    Historyscreen(),
    Homescreen(),
    Withdrawscreen(),
    Chatscreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.orange,
        ),

        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/history.png",
              height: 30,
              width: 30,
              ),
              label: "All Bid",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/statement.png",
                height: 30,
                width: 30,
              ),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/home.png",
                height: 30,
                width: 30,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/withdraw.png",
                height: 30,
                width: 30,
              ),
              label: "Withdraw",
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/support.png",
                height: 30,
                width: 30,
              ),
              label: "Support",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
