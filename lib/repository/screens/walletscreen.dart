import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service.dart';
import '../../utils/session_manager.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({super.key});

  @override
  State<AddFundsScreen> createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {

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

  TextEditingController amountController = TextEditingController();
  List<int> amounts = [500, 1000, 2000, 5000, 10000, 50000, 100000];
  int? selectedAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Add Funds"),
        actions: [
          GestureDetector(
            onTap: () {
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
                  const Icon(Icons.account_balance_wallet, color: Colors.black),
                  const SizedBox(width: 5),
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
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "All in One",
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
            const SizedBox(height: 5),
            const Text("1.0.21", style: TextStyle(fontSize: 12)),
            const SizedBox(height: 10),

            // Telegram Support Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.call, color: Colors.green),
                SizedBox(width: 5),
                Text("Telegram support",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 10),
            const Text.rich(
              TextSpan(
                text: "How to add funds? ",
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: "Click Here",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Info Text
            const Text(
              "Payment add karne ke 5 minute ke andar apke wallet me points add hojayege.\nSo don't worry wait kariye.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.indigo, fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your money is always safe with DpBoss Play",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Amount Input
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "₹ Enter Amount",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "*Please enter minimum 500 Rs",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            const SizedBox(height: 15),

            // Amount Buttons
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: amounts
                  .map(
                    (amt) => ChoiceChip(
                  label: Text("₹$amt"),
                  selected: selectedAmount == amt,
                  onSelected: (selected) {
                    setState(() {
                      selectedAmount = amt;
                      amountController.text = amt.toString();
                    });
                  },
                  selectedColor: Colors.orange.shade300,
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 30),

            // Add Funds Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (amountController.text.isEmpty ||
                      int.parse(amountController.text) < 500) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter minimum 500 Rs")),
                    );
                  } else {
                    // yaha backend call karna hoga
                    print("Adding Funds: ₹${amountController.text}");
                  }
                },
                child: const Text(
                  "ADD FUNDS",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
