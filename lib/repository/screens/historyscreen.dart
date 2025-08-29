import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/history/history_bloc.dart';
import '../../bloc/history/history_event.dart';
import '../../bloc/history/history_state.dart';
import '../../utils/api_helper.dart';
import '../models/models.dart';

class Historyscreen extends StatelessWidget {
  const Historyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoryBloc(ApiHelper())..add(FetchHistoryEvent()),
      child: const BiddingHistoryScreen(),
    );
  }
}

class BiddingHistoryScreen extends StatelessWidget {
  const BiddingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Account Statement",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            if (state.statements.isEmpty) {
              return const Center(child: Text("No history found"));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.statements.length,
              itemBuilder: (context, index) {
                final stmt = state.statements[index];
                return StatementCard(statement: stmt);
              },
            );
          } else if (state is HistoryError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
class StatementCard extends StatelessWidget {
  final StatementModel statement;

  const StatementCard({super.key, required this.statement});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ref: ${statement.referenceId}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(statement.description,
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(statement.date,
                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),

            // Right side amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${statement.isCredit ? "+" : "-"} ₹${statement.transactionAmount}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statement.isCredit ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  statement.status,
                  style: TextStyle(
                    fontSize: 13,
                    color: statement.status.toLowerCase() == "success"
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
