import 'package:all/repository/screens/walletscreen.dart';
import 'package:flutter/material.dart';

class Gamerate extends StatefulWidget {
  const Gamerate({super.key});

  @override
  State<Gamerate> createState() => _GamerateState();
}

class _GamerateState extends State<Gamerate> {
  final List<Map<String, dynamic>> rates = const [
    {"code": "SD", "title": "Single Digit", "rate": "₹10", "color": Colors.pink},
    {"code": "JD", "title": "Jodi Digit", "rate": "₹100", "color": Colors.purple},
    // {"code": "RB", "title": "Red Bracket", "rate": "₹95", "color": Colors.orange},
    {"code": "SP", "title": "Single Pana", "rate": "₹150", "color": Colors.green},
    {"code": "DP", "title": "Double Pana", "rate": "₹300", "color": Colors.red},
    {"code": "TP", "title": "Triple Pana", "rate": "₹1000", "color": Colors.blue},
    {"code": "HS", "title": "Half Sangam", "rate": "₹1000", "color": Colors.deepOrange},
    {"code": "FS", "title": "Full Sangam", "rate": "₹10000", "color": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back button ka action
          },
        ),
        title: Text(
          "Game Rate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  border: Border.all(width: 2,color: Colors.black),
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.account_balance_wallet, color: Colors.black),
                    SizedBox(width: 5),
                    Text("₹393", style: TextStyle(color: Colors.black)),
                  ],
                ),
              )
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Game Win Rates",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: rates.length,
              itemBuilder: (context, index) {
                final item = rates[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: item["color"],
                      radius: 22,
                      child: Text(
                        item["code"],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      item["title"],
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Text(
                      item["rate"],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
        }
}

