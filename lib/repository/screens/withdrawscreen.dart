import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Withdrawscreen extends StatefulWidget {
  const Withdrawscreen({super.key});

  @override
  State<Withdrawscreen> createState() => _WithdrawscreenState();
}

class _WithdrawscreenState extends State<Withdrawscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Withdrawal',
            style: TextStyle(fontWeight: FontWeight.bold)),

      ),
     body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  Text(
                    "Wallet Balance",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "₹ 0",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Enter Amount Field
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Withdrawal Amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.currency_rupee),
              ),
            ),
            const SizedBox(height: 16),

            // Select Bank Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Bank Selection Logic
              },
              child: const Text(
                "Select Bank",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Withdraw Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Withdraw Logic
              },
              child: const Text(
                "WITHDRAW",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const Spacer(),

            // Note
            const Text(
              "Note: Minimum withdrawal amount is ₹500.",
              style: TextStyle(color: Colors.black54, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

