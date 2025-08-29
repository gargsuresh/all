import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/market/market_bloc.dart';
import '../../utils/session_manager.dart';
import '../screens/dashboardscreen.dart';
import 'navbar.dart';

Map<String, dynamic> getBettingStatus(String openTime, String closeTime) {
  DateTime now = DateTime.now();

  DateTime parseTime(String time) {
    final inputFormat = RegExp(r"(\d{1,2}):(\d{2})\s?(AM|PM)", caseSensitive: false);
    final match = inputFormat.firstMatch(time);
    if (match != null) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = match.group(3)!.toUpperCase();
      if (period == "PM" && hour != 12) hour += 12;
      if (period == "AM" && hour == 12) hour = 0;
      return DateTime(now.year, now.month, now.day, hour, minute);
    }
    return now;
  }

  DateTime openDateTime = parseTime(openTime);
  DateTime closeDateTime = parseTime(closeTime);

  if (now.isBefore(openDateTime)) {
    return {"text": "Betting Is Running", "color": Colors.green};
  } else if (now.isAfter(openDateTime) && now.isBefore(closeDateTime)) {
    return {"text": "Betting Is Running For Close", "color": Colors.orange};
  } else {
    return {"text": "Betting Is Closed", "color": Colors.red};
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String walletBalance = "0";

  @override
  void initState() {
    super.initState();
    _loadBalance();
    context.read<MarketBloc>().add(FetchMarkets());
  }

  void _loadBalance() async {
    String bal = await SessionManager.getWalletBalance();
    setState(() {
      walletBalance = bal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      drawer: Navbar(),
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.orange,
        title: const Text('All IN ONE', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.black), color: Colors.orange, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet, color: Colors.black),
                  const SizedBox(width: 6),
                  Text("₹ $walletBalance", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MarketBloc, MarketState>(
          builder: (context, state) {
            if (state is MarketLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.orange));
            } else if (state is MarketLoaded) {
              final markets = state.markets;
              return ListView(
                padding: const EdgeInsets.all(12),
                children: markets.map((m) => GameCard(
                  title: m.name,
                  result: "${m.ank1}-${m.total}${m.total2}-${m.ank2}",
                  openTime: m.opent,
                  closeTime: m.closet,
                  mid: m.mid,
                  cmid: m.cmid,
                  marketName: m.name,
                )).toList(),
              );
            } else if (state is MarketError) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final String result;
  final String openTime;
  final String closeTime;
  final String mid;
  final String cmid;
  final String marketName;

  const GameCard({
    required this.title,
    required this.result,
    required this.openTime,
    required this.closeTime,
    required this.mid,
    required this.cmid,
    required this.marketName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final status = getBettingStatus(openTime, closeTime);

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
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(result, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                const SizedBox(width: 8),
                const Icon(Icons.sports_soccer, color: Colors.orange),
              ],
            ),
            const SizedBox(height: 6),
            Text(status["text"], style: TextStyle(color: status["color"], fontWeight: FontWeight.bold)),
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade500),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(
                          marketName: marketName,
                          mid: mid,
                          cmid: cmid,
                        ),
                      ),
                    );
                  },
                  child: const Text("Place Bet", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
