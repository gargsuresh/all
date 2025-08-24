import 'package:all/repository/screens/doublepatti.dart';
import 'package:all/repository/screens/fullsangam.dart';
import 'package:all/repository/screens/halfsangam.dart';
import 'package:all/repository/screens/singleank.dart';
import 'package:all/repository/screens/singlepatti.dart';
import 'package:all/repository/screens/triplepatti.dart';
import 'package:flutter/material.dart';
import 'jodi.dart';

class DashboardPage extends StatefulWidget {
  final String mid;
  final String cmid;

  const DashboardPage({super.key, required this.mid, required this.cmid});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, String>> cardItems = [
    {"title": "Single Ank", "image": "assets/icons/sing.png"},
    {"title": "Jodi", "image": "assets/icons/jodi.png"},
    {"title": "Single Patti", "image": "assets/icons/single.png"},
    {"title": "Double Patti", "image": "assets/icons/double.png"},
    {"title": "Triple Patti", "image": "assets/icons/triple.png"},
    {"title": "Half Sangam", "image": "assets/icons/half.png"},
    {"title": "Full Sangam", "image": "assets/icons/full.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "DASHBOARD",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemCount: cardItems.length,
          itemBuilder: (context, index) {
            return DashboardCard(
              title: cardItems[index]["title"]!,
              imagePath: cardItems[index]["image"]!,
              onTap: () {
                String _ = cardItems[index]["title"]!;
                if (cardItems[index]["title"] == "Single Ank") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Singleank(
                            mid: widget.mid, cmid: widget.cmid)),
                  );
                } else if (cardItems[index]["title"] == "Jodi") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Jodi(
                              mid: widget.mid,
                              cmid: widget.cmid
                          )
                      )
                  );
                } else if (cardItems[index]["title"] == "Single Patti") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Singlepatti(mid: widget.mid, cmid: widget.cmid)),
                  );
                } else if (cardItems[index]["title"] == "Double Patti") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Doublepatti(mid: widget.mid, cmid: widget.cmid)),
                  );
                } else if (cardItems[index]["title"] == "Triple Patti") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Triplepatti(mid: widget.mid, cmid: widget.cmid)),
                  );
                } else if (cardItems[index]["title"] ==  "Half Sangam") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Halfsangam(mid: widget.mid, cmid: widget.cmid)),
                  );
                } else if (cardItems[index]["title"] == "Full Sangam") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Fullsangam(mid: widget.mid, cmid: widget.cmid)),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const DashboardCard(
      {super.key, required this.title, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFA64D),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                imagePath,
                height: 35,
                width: 35,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
