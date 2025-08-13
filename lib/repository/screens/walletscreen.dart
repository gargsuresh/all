import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Walletscreen extends StatefulWidget{
  @override
  State<Walletscreen> createState() => _WalletscreenState();
}

class _WalletscreenState extends State<Walletscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('WALLET',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back button ka action
          },
        ),
      ),
    );
  }
}