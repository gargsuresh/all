import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Historyscreen extends StatefulWidget {
  const Historyscreen({super.key});

  @override
  State<Historyscreen> createState() => _HistoryscreenState();
}

class _HistoryscreenState extends State<Historyscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BiddingHistoryScreen(),
      debugShowCheckedModeBanner: false,
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
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: statementList.length,
        itemBuilder: (context, index) {
          final stmt = statementList[index];
          return StatementCard(statement: stmt);
        },
      ),
    );
  }
}

// Model
class StatementModel {
  final String referenceId;
  final String transactionAmount;
  final String description;
  final String status;
  final String date;
  final bool isCredit;

  StatementModel({
    required this.referenceId,
    required this.transactionAmount,
    required this.description,
    required this.status,
    required this.date,
    required this.isCredit,
  });
}

// Sample Data
List<StatementModel> statementList = [
  StatementModel(
    referenceId: "77712039",
    transactionAmount: "25.00",
    description: "Bid - MILAN BAZAR MORNING CLOSE - single_patti",
    status: "Debit",
    date: "05 Aug, 2025 11:03:53 AM",
    isCredit: false,
  ),
  StatementModel(
    referenceId: "77711804",
    transactionAmount: "15.00",
    description: "Bid - MILAN BAZAR MORNING CLOSE - single",
    status: "Debit",
    date: "05 Aug, 2025 10:59:34 AM",
    isCredit: false,
  ),
  StatementModel(
    referenceId: "77711704",
    transactionAmount: "25.00",
    description: "Bid - MILAN BAZAR MORNING CLOSE - single",
    status: "Debit",
    date: "05 Aug, 2025 10:59:11 AM",
    isCredit: false,
  ),
];

// Card Widget
class StatementCard extends StatelessWidget {
  final StatementModel statement;
  const StatementCard({required this.statement, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow("Reference ID", statement.referenceId, Colors.orange),
            buildRow("Transaction Amount", statement.transactionAmount, Colors.red),
            buildRow("Description", statement.description, Colors.black),
            buildRow(
              "Status",
              statement.status,
              statement.isCredit ? Colors.green : Colors.red,
            ),
            buildRow("Date", statement.date, Colors.black87),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label : ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: valueColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}




//       Scaffold(
//       backgroundColor: Colors.orange.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: const Text('STATEMENT',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         leading: const Icon(Icons.arrow_back),
//       ),
//     );
//   }
//
// }