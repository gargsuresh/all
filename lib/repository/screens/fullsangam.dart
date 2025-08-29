import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/fullsangam/fullsangam_bloc.dart';
import '../../bloc/fullsangam/fullsangam_event.dart';
import '../../bloc/fullsangam/fullsangam_state.dart';
import '../screens/walletscreen.dart';

class Fullsangam extends StatelessWidget {
  final String mid;
  final String cmid;

  const Fullsangam({super.key, required this.mid, required this.cmid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FullsangamBloc()..add(LoadFullsangam(mid: mid, cmid: cmid)),
      child: BlocBuilder<FullsangamBloc, FullsangamState>(
        builder: (context, state) {
          if (state is FullsangamLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is FullsangamLoaded) {
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
                  "Full Sangam",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AddFundsScreen()),
                      );
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
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Date display
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month, color: Colors.orange),
                          const SizedBox(width: 5),
                          Text(DateFormat('dd/MM/yyyy').format(DateTime.now())),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Input Fields
                    _buildField("Open Panna", state.openPannaController),
                    _buildField("Close Panna", state.closePannaController),
                    _buildField("Points", state.pointsController),

                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, foregroundColor: Colors.white),
                      onPressed: () {
                        context.read<FullsangamBloc>().add(AddEntry());
                      },
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
                              ...state.entries.map((entry) {
                                return TableRow(children: [
                                  _clickableTableCell(entry["Sangam"]!, () {}),
                                  _clickableTableCell(entry["Points"]!, () {}),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.orange),
                                    onPressed: () {
                                      context
                                          .read<FullsangamBloc>()
                                          .add(RemoveEntry(entry: entry));
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
                        context.read<FullsangamBloc>().add(SubmitEntries());
                      },
                      child: Text(
                          "SUBMIT (BIDS=${state.entries.length} POINTS=${state.totalPoints})"),
                    )
                  ],
                ),
              ),
            );
          } else if (state is FullsangamError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
      ),
    );
  }

  Widget _tableCell(String text, bool isHeader) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: isHeader ? Colors.orange.shade100 : Colors.orange.shade100,
      child: Text(
        text,
        style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  Widget _clickableTableCell(String text, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: _tableCell(text, false));
  }
}
