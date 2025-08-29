import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/wallet/wallet_bloc.dart';
import '../../bloc/wallet/wallet_event.dart';
import '../../bloc/wallet/wallet_state.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({super.key});

  @override
  State<AddFundsScreen> createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {
  TextEditingController amountController = TextEditingController();
  List<int> amounts = [500, 1000, 2000, 5000, 10000, 50000, 100000];
  int? selectedAmount;

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(LoadWallet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Add Funds"),
        actions: [
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              String balanceText = "0";
              if (state is WalletLoaded) balanceText = state.walletBalance;
              return Container(
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
                      "₹ $balanceText",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("All in One",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.pink)),
            const SizedBox(height: 5),
            const Text("1.0.21", style: TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
            // Amount Input
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "₹ Enter Amount",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 5),
            const Text("*Please enter minimum 500 Rs", style: TextStyle(color: Colors.red, fontSize: 12)),
            const SizedBox(height: 15),
            // Amount Buttons
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: amounts.map((amt) {
                return ChoiceChip(
                  label: Text("₹$amt"),
                  selected: selectedAmount == amt,
                  onSelected: (selected) {
                    setState(() {
                      selectedAmount = amt;
                      amountController.text = amt.toString();
                    });
                  },
                  selectedColor: Colors.orange.shade300,
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            // Add Funds Button
            SizedBox(
              width: double.infinity,
              child: BlocConsumer<WalletBloc, WalletState>(
                listener: (context, state) {
                  if (state is WalletError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      final amount = int.tryParse(amountController.text) ?? 0;
                      if (amount < 500) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter minimum 500 Rs")),
                        );
                      } else {
                        context.read<WalletBloc>().add(AddFunds(amount));
                      }
                    },
                    child: state is WalletLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("ADD FUNDS", style: TextStyle(fontSize: 16, color: Colors.white)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
