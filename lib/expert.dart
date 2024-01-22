import 'package:flutter/material.dart';
import 'package:test_project/commons/constants.dart';

class Expert extends StatefulWidget {
  const Expert({super.key});

  @override
  State<Expert> createState() => ExpertState();
}

class ExpertState extends State<Expert> {
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
          "Expert",
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
