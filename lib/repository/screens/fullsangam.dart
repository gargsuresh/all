import 'package:all/repository/screens/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/session_manager.dart';

class Fullsangam extends StatefulWidget {
  final String mid;
  final String cmid;
  const Fullsangam({super.key, required this.mid, required this.cmid});

  @override
  State<Fullsangam> createState() => _FullsangamState();
}

class _FullsangamState extends State<Fullsangam> {


  String walletBalance = "0";

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  void _loadBalance() async {
    String bal = await SessionManager.getWalletBalance();
    setState(() {
      walletBalance = bal;
    });
  }

  String get selectedDate => DateFormat('dd/MM/yyyy').format(DateTime.now());

  TextEditingController openPannaController = TextEditingController();
  TextEditingController closePannaController = TextEditingController();
  TextEditingController pointsController = TextEditingController();

  List<Map<String, String>> entries = [];

  void _addEntry() {
    if (openPannaController.text.isNotEmpty &&
        closePannaController.text.isNotEmpty &&
        pointsController.text.isNotEmpty) {
      setState(() {
        entries.add({
          "Sangam": "${openPannaController.text}-${closePannaController.text}",
          "Points": pointsController.text,
          "GameType": "open"
        });
        openPannaController.clear();
        closePannaController.clear();
        pointsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Full Sangam",
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
                  children:[
                    Icon(Icons.account_balance_wallet, color: Colors.black),
                    SizedBox(width: 5),

                    Text(
                      "₹ $walletBalance",
                      style: TextStyle(
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
            // Date Box - No picker, only today's date
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.orange),
                  const SizedBox(width: 5),
                  Text(selectedDate),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Input Fields
            _buildClickableField("Open Panna", openPannaController),
            _buildClickableField("Close Panna", closePannaController),
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
                    border: TableBorder.all(color: Colors.black),

                    children: [
                      TableRow(children: [
                        _tableCell("Sangam", true),
                        _tableCell("Points", true),
                        _tableCell("", true),
                      ]),
                      ...entries.map((entry) {
                        return TableRow(children: [
                          _clickableTableCell(entry["Sangam"]!, () {}),
                          _clickableTableCell(entry["Points"]!, () {}),
                          IconButton(
                            icon:
                            const Icon(Icons.delete, color: Colors.orange),
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
                ("Submit Clicked");
              },
              child: Text(
                  "SUBMIT (BIDS=${entries.length} POINTS=${entries.fold(0, (sum, e) => sum + int.parse(e['Points']!))})"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClickableField(
      String label, TextEditingController controller) {
    return Container(
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
    );
  }

  Widget _tableCell(String text, bool isHeader) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: isHeader ? Colors.orange.shade100 : Colors.orange.shade100,
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
