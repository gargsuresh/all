import 'dart:convert';

import 'package:all/repository/screens/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../utils/session_manager.dart';

class Triplepatti extends StatefulWidget {
  final String mid;
  final String cmid;
  const Triplepatti({super.key, required this.mid, required this.cmid});

  @override
  State<Triplepatti> createState() => _TriplepattiState();
}

class _TriplepattiState extends State<Triplepatti> {
  String walletBalance = "0";
  String marketName = ""; // ✅ Dynamic market name

  @override
  void initState() {
    super.initState();
    _loadBalance();
    _fetchMarketName();
  }

  void _loadBalance() async {
    String bal = await SessionManager.getWalletBalance();
    setState(() {
      walletBalance = bal;
    });
  }

  Future<void> _fetchMarketName() async {
    try {
      final response = await http.get(Uri.parse("https://atozmatka.com/api/get_markets.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final marketsJson = data["markets"] as List;

        final market = marketsJson.firstWhere(
              (m) => m["mid"] == widget.mid && m["cmid"] == widget.cmid,
          orElse: () => null,
        );

        if (market != null) {
          setState(() {
            marketName = market["name"] ?? "Unknown Market";
          });
        } else {
          setState(() {
            marketName = "Unknown Market";
          });
        }
      }
    } catch (e) {
      setState(() {
        marketName = "Unknown Market";
      });
    }
  }




  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final TextEditingController digitController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();

  List<Map<String, String>> bids = [];


  @override
  Widget build(BuildContext context) {
    selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
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
          "Triple Patti Dashboard",
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
                  children: [
                    const Icon(Icons.account_balance_wallet, color: Colors.black),
                    const SizedBox(width: 5),
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
              )
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(Icons.calendar_today, selectedDate),
                _customButton(null, marketName),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _inputField("Single Digit", "Enter Digit", digitController)),
                SizedBox(width: 10),
                Expanded(child: _inputField("Points", "Enter Points", pointsController)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (digitController.text.isNotEmpty &&
                    pointsController.text.isNotEmpty) {
                  setState(() {
                    bids.add({
                      "digit": digitController.text,
                      "points": pointsController.text,
                      "type": "close"
                    });
                  });
                  digitController.clear();
                  pointsController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFA64D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text("ADD", style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: bids.isEmpty
                  ? Center(child: Text("No bids added"))
                  : ListView.builder(
                itemCount: bids.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      title: Text(
                        "Digit: ${bids[index]['digit']} | Points: ${bids[index]['points']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Game Type: ${bids[index]['type']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.orange),
                        onPressed: () {
                          setState(() {
                            bids.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Submit functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFA64D),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "SUBMIT (BIDS=${bids.length} POINTS=${_totalPoints()})",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton(IconData? icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)
        ],
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.orange),
          if (icon != null) SizedBox(width: 8),
          Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _inputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  int _totalPoints() {
    int total = 0;
    for (var bid in bids) {
      total += int.tryParse(bid['points']!) ?? 0;
    }
    return total;
  }
}
