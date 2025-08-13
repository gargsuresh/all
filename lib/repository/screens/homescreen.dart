import 'package:all/repository/screens/dashboardscreen.dart';
import 'package:all/repository/screens/walletscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/constants/appcolors.dart';
import 'navbar.dart';


class Homescreen extends StatefulWidget{
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      drawer: Navbar(),
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.orange,
        title: Row(
          children: const [
            SizedBox(width: 8),
            Text.rich(
              TextSpan(
                text: 'All IN ONE',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        // leading: IconButton(onPressed: (){
        // }, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Walletscreen()));
          }, icon: Icon(Icons.account_balance_wallet_outlined))
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const HeaderRow(),
            const SizedBox(height: 12),
            GameCard(
              title: "SITA MORNING",
              result: "490-3*-***",
              openTime: "09:40 AM",
              closeTime: "10:40 AM",
            ),
            GameCard(
              title: "KARNATAKA DAY",
              result: "***-**-***",
              openTime: "09:55 AM",
              closeTime: "10:55 AM",
            ),
            GameCard(
              title: "STAR TARA MORNING",
              result: "280-0*-***",
              openTime: "10:05 AM",
              closeTime: "11:05 AM",
            ),
            GameCard(
              title: "MILAN MORNING",
              result: "***-**-***",
              openTime: "10:10 AM",
              closeTime: "11:10 AM",
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            HeaderButton(text: "STARLINE", icon: Icons.star),
            HeaderButton(text: "GAMES", icon: Icons.airplane_ticket),
            HeaderButton(text: "JACKPOT", icon: Icons.play_circle),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            HeaderButton(text: "+918866095777", icon: Icons.phone),
            HeaderButton(text: "+918866095777", icon: Icons.chat)

          ],
        ),
      ],
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const HeaderButton({required this.text, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      avatar: Icon(icon, size: 16),
      backgroundColor: Colors.orange,
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final String result;
  final String openTime;
  final String closeTime;

  const GameCard({
    required this.title,
    required this.result,
    required this.openTime,
    required this.closeTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(result,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange)),
                const SizedBox(width: 8),
                const Icon(Icons.sports_soccer, color: Colors.orange),
              ],
            ),
            const SizedBox(height: 6),
            const Text("Betting Is Running For Close",
                style: TextStyle(color: Colors.orange)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("Open "),
                Text(openTime, style: const TextStyle(color: Colors.orange)),
                const SizedBox(width: 12),
                const Text("Close "),
                Text(closeTime, style: const TextStyle(color: Colors.orange)),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade500,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
                  },
                  child: const Text("Place Bet",
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}