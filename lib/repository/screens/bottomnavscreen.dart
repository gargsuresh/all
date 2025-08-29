import 'package:all/repository/screens/withdrawscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bottomnav/bottomnav_bloc.dart';
import 'allbidscreen.dart';
import 'chatscreen.dart';
import 'historyscreen.dart';
import 'homescreen.dart';

class BottomNavscreen extends StatelessWidget {
  const BottomNavscreen({super.key});

  final List<Widget> pages = const [
    AllBidscreen(),
    Historyscreen(),
    Homescreen(),
    Withdrawscreen(),
    Chatscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: pages,
            ),
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(indicatorColor: Colors.orange),
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/history.png", height: 30, width: 30),
                    label: "All Bid",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/statement.png", height: 30, width: 30),
                    label: "History",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/home.png", height: 30, width: 30),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/withdraw.png", height: 30, width: 30),
                    label: "Withdraw",
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/support.png", height: 30, width: 30),
                    label: "Support",
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: state.currentIndex,
                onTap: (index) => context.read<BottomNavCubit>().updateIndex(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
