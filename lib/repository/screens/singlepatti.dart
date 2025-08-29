import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../utils/api_helper.dart';
import '../screens/walletscreen.dart';

class Singlepatti extends StatefulWidget {
  final String mid;
  final String cmid;

  const Singlepatti({super.key, required this.mid, required this.cmid});

  @override
  State<Singlepatti> createState() => _SinglepattiState();
}

class _SinglepattiState extends State<Singlepatti> {
  String walletBalance = "0";
  String marketName = "";

  final TextEditingController digitController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();
  List<Map<String, String>> bids = [];

  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String bal = await ApiHelper.getWalletBalance();
    String market = await ApiHelper.getMarketName(widget.mid, widget.cmid);
    setState(() {
      walletBalance = bal;
      marketName = market;
    });
  }

  void _addBid() {
    if (digitController.text.isNotEmpty && pointsController.text.isNotEmpty) {
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
  }

  int _totalPoints() => bids.fold(0, (sum, bid) => sum + (int.tryParse(bid['points']!) ?? 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Single Patti Dashboard", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddFundsScreen())),
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
                  const Icon(Icons.account_balance_wallet, color: Colors.black),
                  const SizedBox(width: 5),
                  Text("₹ $walletBalance", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _customButton(Icons.calendar_today, selectedDate),
              _customButton(null, marketName),
            ]),
            SizedBox(height: 20),
            Row(children: [
              Expanded(child: _inputField("Single Digit", "Enter Digit", digitController, singleDigitOnly: true)),
              SizedBox(width: 10),
              Expanded(child: _inputField("Points", "Enter Points", pointsController)),
            ]),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _addBid, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFA64D)), child: Text("ADD", style: TextStyle(color: Colors.black))),
            SizedBox(height: 20),
            Expanded(
              child: bids.isEmpty
                  ? Center(child: Text("No bids added"))
                  : ListView.builder(
                itemCount: bids.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      title: Text("Digit: ${bids[index]['digit']} | Points: ${bids[index]['points']}"),
                      subtitle: Text("Game Type: ${bids[index]['type']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.orange),
                        onPressed: () => setState(() => bids.removeAt(index)),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {}, // Submit function
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFA64D), padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              child: Text("SUBMIT (BIDS=${bids.length} POINTS=${_totalPoints()})", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton(IconData? icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.orange),
          if (icon != null) SizedBox(width: 8),
          Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _inputField(String label, String hint, TextEditingController controller, {bool singleDigitOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: singleDigitOnly
              ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(1)]
              : [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
