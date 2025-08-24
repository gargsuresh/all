import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:all/repository/screens/dashboardscreen.dart';
import 'package:all/repository/screens/walletscreen.dart';
import '../../utils/session_manager.dart';
import 'navbar.dart';
import '../../repository/models/market_model.dart';

/// ✅ Top-level function for dynamic betting status
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
    return {"text": "Betting Is Running", "color": Colors.green};
  } else if (now.isAtSameMomentAs(closeDateTime)) {
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
  List<Market> markets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBalance();
    fetchMarkets();
  }

  void _loadBalance() async {
    String bal = await SessionManager.getWalletBalance();
    setState(() {
      walletBalance = bal;
    });
  }

  Future<void> fetchMarkets() async {
    final response = await http.get(Uri.parse("https://atozmatka.com/api/get_markets.php"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final marketsJson = data["markets"] as List;
      final List<Market> fetchedMarkets = marketsJson.map((e) => Market.fromJson(e)).toList();

      // Sort markets by open_time
      fetchedMarkets.sort((a, b) {
        DateTime timeA = _parseTime(a.opent);
        DateTime timeB = _parseTime(b.opent);
        return timeA.compareTo(timeB);
      });

      setState(() {
        markets = fetchedMarkets;
        isLoading = false;
      });
    } else {
      throw Exception("Failed to load markets");
    }
  }

  DateTime _parseTime(String time) {
    try {
      final inputFormat = RegExp(r"(\d{1,2}):(\d{2})\s?(AM|PM)", caseSensitive: false);
      final match = inputFormat.firstMatch(time);
      if (match != null) {
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        String period = match.group(3)!.toUpperCase();
        if (period == "PM" && hour != 12) hour += 12;
        if (period == "AM" && hour == 12) hour = 0;
        return DateTime.now().copyWith(hour: hour, minute: minute);
      }
    } catch (e) {}
    return DateTime.now();
  }

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
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddFundsScreen()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: Colors.black),
                    const SizedBox(width: 6),
                    Text(
                      "₹ $walletBalance",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.orange))
            : ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const HeaderRow(),
            const SizedBox(height: 12),
            ...markets.map((m) => GameCard(
              title: m.name,
              result: "${m.ank1}-${m.total}${m.total2}-${m.ank2}",
              openTime: m.opent,
              closeTime: m.closet, mid: m.mid, cmid: m.cmid,
            )),
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
  final String mid;   // primary market id
  final String cmid;  // secondary market id

  const GameCard({
    required this.title,
    required this.result,
    required this.openTime,
    required this.closeTime,
    required this.mid,
    required this.cmid,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final status = getBettingStatus(openTime, closeTime); // ✅ Dynamic status

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
            Text(
              status["text"],
              style: TextStyle(
                color: status["color"],
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    // ✅ Pass only mid and cmid
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(
                          mid: mid,
                          cmid: cmid,
                        ),
                      ),
                    );
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
