import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget{
  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('CHAT',
            style: TextStyle(fontWeight: FontWeight.bold)),

      ),
    );
  }
}