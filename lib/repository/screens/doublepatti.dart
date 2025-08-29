import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/doublepatti/doublepatti_bloc.dart';
import '../../bloc/doublepatti/doublepatti_event.dart';
import '../../bloc/doublepatti/doublepatti_state.dart';
import '../screens/walletscreen.dart';
import 'package:intl/intl.dart';

class Doublepatti extends StatelessWidget {
  final String mid;
  final String cmid;
  const Doublepatti({super.key, required this.mid, required this.cmid});

  @override
  Widget build(BuildContext context) {
    final digitController = TextEditingController();
    final pointsController = TextEditingController();
    final selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return BlocProvider(
      create: (_) => DoublepattiBloc()..add(LoadDoublepatti(mid: mid, cmid: cmid)),
      child: BlocBuilder<DoublepattiBloc, DoublepattiState>(
        builder: (context, state) {
          if (state is DoublepattiLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is DoublepattiLoaded) {
            return Scaffold(
              backgroundColor: Colors.orange.shade100,
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  "Double Patti Dashboard",
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
                            "₹ ${state.walletBalance}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
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
                          child: _inputField("Single Digit", "Enter Digit", digitController),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _inputField("Points", "Enter Points", pointsController),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (digitController.text.isNotEmpty && pointsController.text.isNotEmpty) {
                          context.read<DoublepattiBloc>().add(AddBid(
                              digit: digitController.text,
                              points: pointsController.text));
                          digitController.clear();
                          pointsController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA64D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text("ADD", style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: state.bids.isEmpty
                          ? const Center(child: Text("No bids added"))
                          : ListView.builder(
                        itemCount: state.bids.length,
                        itemBuilder: (context, index) {
                          final bid = state.bids[index];
                          return Card(
                            elevation: 1,
                            child: ListTile(
                              title: Text(
                                "Digit: ${bid['digit']} | Points: ${bid['points']}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Game Type: ${bid['type']}"),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.orange),
                                onPressed: () {
                                  context.read<DoublepattiBloc>().add(RemoveBid(index: index));
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Submit API call
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA64D),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Text(
                        "SUBMIT (BIDS=${state.bids.length} POINTS=${_totalPoints(state.bids)})",
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is DoublepattiError) {
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

  Widget _inputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey),
            ),
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
