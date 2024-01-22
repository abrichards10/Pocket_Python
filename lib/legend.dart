import 'package:flutter/material.dart';
import 'package:test_project/commons/constants.dart';

class Legend extends StatefulWidget {
  const Legend({super.key});

  @override
  State<Legend> createState() => LegendState();
}

class LegendState extends State<Legend> {
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
          "Intermediate",
          style: TextStyle(
            fontFamily: mainFont.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
