import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../bloc/jodi/jodi_bloc.dart';
import '../../bloc/jodi/jodi_event.dart';
import '../../bloc/jodi/jodi_state.dart';
import '../screens/walletscreen.dart';

class Jodi extends StatelessWidget {
  final String mid;
  final String cmid;

  const Jodi({super.key, required this.mid, required this.cmid});

  @override
  Widget build(BuildContext context) {
    final digitController = TextEditingController();
    final pointsController = TextEditingController();
    final selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return BlocProvider(
      create: (_) => JodiBloc()..add(LoadJodi(mid: mid, cmid: cmid)),
      child: BlocBuilder<JodiBloc, JodiState>(
        builder: (context, state) {
          if (state is JodiLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is JodiLoaded) {
            return Scaffold(
              backgroundColor: Colors.orange.shade100,
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: const Text(
                  "Jodi Dashboard",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => AddFundsScreen())),
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
                            "₹ ${state.walletBalance}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _customButton(Icons.calendar_today, selectedDate),
                        _customButton(null, state.marketName),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _inputField(
                            "Single Digit",
                            "Enter Digit",
                            digitController,
                            maxLength: 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _inputField(
                            "Points",
                            "Enter Points",
                            pointsController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (digitController.text.isNotEmpty &&
                            pointsController.text.isNotEmpty) {
                          int numValue = int.tryParse(digitController.text) ?? -1;
                          if (numValue >= 0 && numValue <= 99) {
                            context.read<JodiBloc>().add(AddBid(
                                digit: digitController.text,
                                points: pointsController.text));
                            digitController.clear();
                            pointsController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text("Please enter a number between 00 and 99")),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA64D),
                      ),
                      child:
                      const Text("ADD", style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: state.bids.isEmpty
                          ? const Center(child: Text("No bids added"))
                          : ListView.builder(
                        itemCount: state.bids.length,
                        itemBuilder: (_, index) {
                          final bid = state.bids[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                  "Digit: ${bid['digit']} | Points: ${bid['points']}"),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.orange),
                                onPressed: () => context
                                    .read<JodiBloc>()
                                    .add(RemoveBid(index: index)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Submit API call
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFA64D),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15)),
                      child: Text(
                        "SUBMIT (BIDS=${state.bids.length} POINTS=${_totalPoints(state.bids)})",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is JodiError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _customButton(IconData? icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.orange),
          if (icon != null) const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _inputField(String label, String hint, TextEditingController controller,
      {int maxLength = 2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(maxLength)
          ],
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  int _totalPoints(List<Map<String, String>> bids) {
    int total = 0;
    for (var bid in bids) {
      total += int.tryParse(bid['points']!) ?? 0;
    }
    return total;
  }
}
