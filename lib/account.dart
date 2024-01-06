// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/commons/commons.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => AccountState();
}

class AccountState extends State<Account> {
  final mainFont = GoogleFonts.comicNeue();
  final mainColor = const Color.fromARGB(255, 252, 221, 253);
  final TextEditingController _textEditingController1 = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  late ConfettiController _controllerCenter; // CONFETTI! :D

  @override
  void initState() {
    _textEditingController1.text = PrefsHelper().accountName;
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose(); // Dispose of confetti
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget gradientDecor() {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 253, 207, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        gradientDecor(),
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: mainColor,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              confetti(_controllerCenter),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: height / 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/elmo_on_fire.png'),
                        radius: height / 10,
                      ),
                      SizedBox(height: height / 30),
                      Form(
                        key: formKey1,
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Text(
                                _textEditingController1.text,
                                style: TextStyle(
                                    fontFamily: mainFont.fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Card(
                                      margin: EdgeInsets.fromLTRB(
                                          50,
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                          50,
                                          MediaQuery.of(context).size.height /
                                              2.5),
                                      child: TextField(
                                        controller: _textEditingController1,
                                        style: mainFont,
                                        decoration: InputDecoration(
                                          hintText: "Name",
                                          labelText: '',
                                        ),
                                        autofocus: false,
                                        maxLength: 30,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        onSubmitted: (value) {
                                          PrefsHelper().accountName = value;
                                          _textEditingController1.text = value;
                                          _controllerCenter.play(); // Confetti!
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height / 2.2),
                child: Container(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: height / 2.6, left: width / 20, right: width / 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color.fromARGB(255, 254, 235, 255),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 2.0,
                              offset: Offset(0.0, 2.0))
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width / 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            headerChild('Level', "114"),
                            // headerChild('Skills', "1205"),
                            headerChild('ⴵ Time Spent', timeSpent()),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 20),
                      child: Column(
                        children: <Widget>[
                          infoChild(width / 3, Icons.email, 'email'),
                          infoChild(width / 3, Icons.call, 'phone number'),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  String timeSpent() {
    int time = PrefsHelper().timeElapsedInLesson;
    String label = " seconds";

    if (time >= 2592000) {
      int months = (time / 2592000).round();
      int days = ((time / 86400) - (months * 30)).round();
      time = months;
      String monthLabel = "month";
      String dayLabel = "day";

      if (time > 1) {
        monthLabel = "months";
      } else {
        monthLabel = "month";
      }

      if (days > 1) {
        dayLabel = "days";
      } else {
        dayLabel = "day";
      }

      if (days > 0) {
        label = " $monthLabel $days $dayLabel";
      } else {
        label = " $monthLabel";
      }
    }

    if (time >= 86400) {
      int days = (time / 86400).round();
      int hours = ((time / 3600) - (days * 24)).round();
      time = days;
      String dayLabel = "day";
      String hourLabel = "hour";

      if (time > 1) {
        dayLabel = "days";
      } else {
        dayLabel = "day";
      }

      if (hours > 1) {
        hourLabel = "hours";
      } else {
        hourLabel = "hour";
      }

      if (hours > 0) {
        label = " $dayLabel $hours $hourLabel";
      } else {
        label = " $dayLabel";
      }
    }

    if (time >= 3600) {
      int hours = (time / 3600).round();
      int minutes = ((time / 60) - (hours * 60)).round();
      time = hours;
      String hourLabel = "hour";
      String minuteLabel = "minute";

      if (time > 1) {
        hourLabel = "hours";
      } else {
        hourLabel = "hour";
      }

      if (minutes > 1) {
        minuteLabel = "minutes";
      } else {
        minuteLabel = "minute";
      }

      if (minutes > 0) {
        label = " $hourLabel $minutes $minuteLabel";
      } else {
        label = " $hourLabel";
      }
    }

    if (time >= 60) {
      time = (time / 60).round();

      String minuteLabel = "minute";

      if (time > 1) {
        minuteLabel = "minutes";
      } else {
        minuteLabel = "minute";
      }

      label = " $minuteLabel";
    }
    return time.toString() + label;
  }

  Widget headerChild(String header, String value) => Expanded(
        child: Column(
          children: <Widget>[
            Text(
              header,
              style: GoogleFonts.comicNeue(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              '$value',
              style: GoogleFonts.comicNeue(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );

  Widget infoChild(double width, IconData icon, data) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: width / 10,
              ),
              Icon(
                icon,
                color: Color.fromARGB(255, 232, 136, 235),
                size: 36.0,
              ),
              SizedBox(
                width: width / 20,
              ),
              Text(
                data,
                style: GoogleFonts.comicNeue(
                  fontSize: 18.0,
                ),
              )
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
}
