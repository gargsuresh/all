import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/widthraw/withdraw_bloc.dart';
import '../../bloc/widthraw/withdraw_event.dart';
import '../../bloc/widthraw/withdraw_state.dart';
import 'walletscreen.dart';

class Withdrawscreen extends StatefulWidget {
  const Withdrawscreen({super.key});

  @override
  State<Withdrawscreen> createState() => _WithdrawscreenState();
}

class _WithdrawscreenState extends State<Withdrawscreen> {
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WithdrawBloc>().add(LoadWalletBalance());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Withdrawal', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddFundsScreen()));
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black),
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: BlocBuilder<WithdrawBloc, WithdrawState>(
                builder: (context, state) {
                  String balance = "0";
                  if (state is WithdrawLoaded) balance = state.walletBalance;
                  return Row(
                    children: [
                      const Icon(Icons.account_balance_wallet, color: Colors.black),
                      const SizedBox(width: 5),
                      Text("₹ $balance", style: const TextStyle(color: Colors.black)),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Enter Amount
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Withdrawal Amount",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.currency_rupee),
              ),
            ),
            const SizedBox(height: 16),
            // Withdraw Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final amount = int.tryParse(amountController.text) ?? 0;
                if (amount < 500) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Minimum withdrawal is ₹500")));
                } else {
                  context.read<WithdrawBloc>().add(WithdrawAmount(amount));
                }
              },
              child: const Text("WITHDRAW", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            BlocConsumer<WithdrawBloc, WithdrawState>(
              listener: (context, state) {
                if (state is WithdrawSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Withdrawal Successful")));
                } else if (state is WithdrawFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is WithdrawLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
