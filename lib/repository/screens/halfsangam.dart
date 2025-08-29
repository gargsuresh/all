import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/halfsangam/halfsangam_bloc.dart';
import '../../bloc/halfsangam/halfsangam_event.dart';
import '../../bloc/halfsangam/halfsangam_state.dart';
import 'walletscreen.dart';

class HalfsangamScreen extends StatefulWidget {
  final String mid;
  final String cmid;

  const HalfsangamScreen({super.key, required this.mid, required this.cmid});

  @override
  State<HalfsangamScreen> createState() => _HalfsangamScreenState();
}

class _HalfsangamScreenState extends State<HalfsangamScreen> {
  late TextEditingController firstController;
  late TextEditingController secondController;
  late TextEditingController pointsController;

  String firstLabel = "Open Digit";
  String secondLabel = "Close Panna";

  @override
  void initState() {
    super.initState();
    firstController = TextEditingController();
    secondController = TextEditingController();
    pointsController = TextEditingController();

    // Load initial data
    context.read<HalfsangamBloc>().add(LoadHalfsangam(mid: widget.mid, cmid: widget.cmid));
  }

  void _swapFields() {
    setState(() {
      final tempLabel = firstLabel;
      firstLabel = secondLabel;
      secondLabel = tempLabel;

      final tempController = firstController;
      firstController = secondController;
      secondController = tempController;
    });
  }

  void _addEntry() {
    final sangam = "${firstController.text}-${secondController.text}";
    final points = pointsController.text;

    if (firstController.text.isNotEmpty &&
        secondController.text.isNotEmpty &&
        points.isNotEmpty) {
      context.read<HalfsangamBloc>().add(AddEntry(sangam: sangam, points: points));
      firstController.clear();
      secondController.clear();
      pointsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return BlocBuilder<HalfsangamBloc, HalfsangamState>(
      builder: (context, state) {
        if (state is HalfsangamLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HalfsangamLoaded) {
          final totalPoints = state.entries.fold<int>(0, (sum, e) => sum + int.parse(e['Points']!));

          return Scaffold(
            backgroundColor: Colors.orange.shade100,
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: const Text(
                "Half Sangam",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
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
                        Text("₹ ${state.walletBalance}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Date + Swap Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month, color: Colors.orange),
                            const SizedBox(width: 5),
                            Text(selectedDate),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _swapFields,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                        child: const Text("Change"),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Input fields
                  _buildTextField(firstLabel, firstController),
                  _buildTextField(secondLabel, secondController),
                  _buildTextField("Points", pointsController),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addEntry,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: const Text("ADD"),
                  ),
                  const SizedBox(height: 15),
                  // Entries Table
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
                            ...state.entries.asMap().entries.map((entryMap) {
                              final index = entryMap.key;
                              final entry = entryMap.value;
                              return TableRow(children: [
                                _clickableTableCell(entry["Sangam"]!, () {}),
                                _clickableTableCell(entry["Points"]!, () {}),
                                _clickableTableCell(entry["GameType"]!, () {}),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.orange),
                                  onPressed: () => context.read<HalfsangamBloc>().add(RemoveEntry(index: index)),
                                ),
                              ]);
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      // Submit API call
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: Text("SUBMIT (BIDS=${state.entries.length} POINTS=$totalPoints)"),
                  ),
                ],
              ),
            ),
          );
        } else if (state is HalfsangamError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))]),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
      ),
    );
  }

  Widget _tableCell(String text, bool isHeader) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: isHeader ? Colors.orange.shade100 : Colors.white,
      child: Text(text, style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
    );
  }

  Widget _clickableTableCell(String text, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: _tableCell(text, false));
  }
}
