import 'dart:convert';

import 'package:all/repository/screens/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../utils/session_manager.dart';

class Halfsangam extends StatefulWidget {
  final String mid;
  final String cmid;
  const Halfsangam({super.key, required this.mid, required this.cmid});

  @override
  State<Halfsangam> createState() => _HalfsangamState();
}

class _HalfsangamState extends State<Halfsangam> {

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

  TextEditingController openDigitController = TextEditingController();
  TextEditingController closePannaController = TextEditingController();
  TextEditingController pointsController = TextEditingController();

  String firstLabel = "Open Digit";
  String secondLabel = "Close Panna";

  List<Map<String, String>> entries = [];

  void _swapFields() {
    setState(() {
      // Labels swap
      String tempLabel = firstLabel;
      firstLabel = secondLabel;
      secondLabel = tempLabel;

      // Controllers swap
      TextEditingController tempController = openDigitController;
      openDigitController = closePannaController;
      closePannaController = tempController;
    });
  }

  void _addEntry() {
    if (openDigitController.text.isNotEmpty &&
        closePannaController.text.isNotEmpty &&
        pointsController.text.isNotEmpty) {
      setState(() {
        entries.add({
          "Sangam": "${openDigitController.text}-${closePannaController.text}",
          "Points": pointsController.text,
          "GameType": "open"
        });
        openDigitController.clear();
        closePannaController.clear();
        pointsController.clear();
      });
    }
  }

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
        title: const Text(
          "Half Sangam",
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Date Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, color: Colors.orange),
                          const SizedBox(width: 5),
                          Text(selectedDate),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _swapFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Change"),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Input Fields
            _buildClickableField(firstLabel, openDigitController),
            _buildClickableField(secondLabel, closePannaController),
            _buildClickableField("Points", pointsController),

            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, foregroundColor: Colors.white),
              onPressed: _addEntry,
              child: const Text("ADD"),
            ),

            const SizedBox(height: 15),

            // Table
            Expanded(
              child: ListView(
                children: [
                  Table(
                    border: TableBorder.all(color: Colors.grey),
                    children: [
                      TableRow(children: [
                        _tableCell("Sangam", true),
                        _tableCell("Points", true),
                        _tableCell("Game Type", true),
                        _tableCell("", true),
                      ]),
                      ...entries.map((entry) {
                        return TableRow(children: [
                          _clickableTableCell(entry["Sangam"]!, () {
                            print("Clicked Sangam: ${entry['Sangam']}");
                          }),
                          _clickableTableCell(entry["Points"]!, () {
                            print("Clicked Points: ${entry['Points']}");
                          }),
                          _clickableTableCell(entry["GameType"]!, () {
                            print("Clicked Game Type: ${entry['GameType']}");
                          }),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.orange),
                            onPressed: () {
                              setState(() {
                                entries.remove(entry);
                              });
                            },
                          ),
                        ]);
                      })
                    ],
                  ),
                ],
              ),
            ),

            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, foregroundColor: Colors.white),
              onPressed: () {
                print("Submit Clicked");
              },
              child: Text(
                  "SUBMIT (BIDS=${entries.length} POINTS=${entries.fold(0, (sum, e) => sum + int.parse(e['Points']!))})"),
            )
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










  Widget _buildClickableField(
      String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () {
        print("Clicked on $label");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
          ],
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _tableCell(String text, bool isHeader) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: isHeader ? Colors.orange.shade100 : Colors.white,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  Widget _clickableTableCell(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: _tableCell(text, false),
    );
  }
}
