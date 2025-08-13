  import 'package:all/repository/screens/walletscreen.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
  import 'package:intl/intl.dart';

  class Singleank extends StatefulWidget {
    const Singleank({super.key});

    @override
    State<Singleank> createState() => _SingleankState();
  }

  class _SingleankState extends State<Singleank> {
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
            "Single Ank Dashboard",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black, width: 1),
                // borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Walletscreen()));
                    }, icon: Icon(Icons.account_balance_wallet_outlined)),

                  SizedBox(width: 5),
                  //Text("393", style: TextStyle(color: Colors.black)),
                ],
              ),
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
                  _customButton(null, "MILAN DAY CLOSE"),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _inputField("Single Digit", "Enter Digit", digitController, singleDigitOnly: true)),
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
                ? [
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9]$')),
              LengthLimitingTextInputFormatter(1), // Sirf ek digit
            ]
                : [
              FilteringTextInputFormatter.digitsOnly,
            ],
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
