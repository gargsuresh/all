import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllBidscreen extends StatefulWidget{
  @override
  State<AllBidscreen> createState() => _AllBidscreenState();
}

class _AllBidscreenState extends State<AllBidscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Bidding History',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: bidList.length,
        itemBuilder: (context, index) {
          final bid = bidList[index];
          return BidCard(bid: bid);
        },
      ),
    );
  }
}

// Model
class BidModel {
  final String title;
  final String digit;
  final String points;
  final String time;
  final String message;
  final bool isWin;
  final String bidId;

  BidModel({
    required this.title,
    required this.digit,
    required this.points,
    required this.time,
    required this.message,
    required this.isWin,
    required this.bidId,
  });
}

// Sample Data
List<BidModel> bidList = [
  BidModel(
    title: "MILAN BAZAR MORNING CLOSE - single_patti",
    digit: "367",
    points: "25.00",
    time: "05 Aug 11:03 AM",
    message: "Better Luck Next Time!!! 😔",
    isWin: false,
    bidId: "77712039",
  ),
  BidModel(
    title: "MILAN BAZAR MORNING CLOSE - single",
    digit: "1",
    points: "15.00",
    time: "05 Aug 10:59 AM",
    message: "Better Luck Next Time!!! 😔",
    isWin: false,
    bidId: "77711804",
  ),
  BidModel(
    title: "KALYAN NIGHT CLOSE - single",
    digit: "4",
    points: "25.00",
    time: "04 Aug 09:55 PM",
    message: "You Won Rs. 238 🎉",
    isWin: true,
    bidId: "77690270",
  ),
  BidModel(
    title: "KALYAN NIGHT OPEN - jodi",
    digit: "90",
    points: "20.00",
    time: "04 Aug 07:10 PM",
    message: "Better Luck Next Time!!! 😔",
    isWin: false,
    bidId: "77669050",
  ),
];

// Card Widget
class BidCard extends StatelessWidget {
  final BidModel bid;
  const BidCard({required this.bid, super.key});

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
            Row(
              children: [
                Expanded(
                  child: Text(
                    bid.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                ),
                Text("✮ ${bid.bidId}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text("Digit: ${bid.digit}"),
                const SizedBox(width: 12),
                Text("Points: ${bid.points}"),
                const SizedBox(width: 12),
                Text("Time: ${bid.time}"),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              bid.message,
              style: TextStyle(
                color: bid.isWin ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
