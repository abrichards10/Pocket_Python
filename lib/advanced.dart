import 'package:flutter/material.dart';
import 'package:test_project/commons/constants.dart';

class Advanced extends StatefulWidget {
  const Advanced({super.key});

  @override
  State<Advanced> createState() => AdvancedState();
}

class AdvancedState extends State<Advanced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Advanced",
          style: TextStyle(
              fontFamily: mainFont.fontFamily, fontWeight: FontWeight.w600),
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
