// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/commons/commons.dart';
import 'package:test_project/commons/constants.dart';
import 'package:test_project/image_permissions/media_service.dart';
import 'dart:math' as math;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => AccountState();
}

class AccountState extends State<Account> with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController1 = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  late ConfettiController _controllerCenter; // CONFETTI! :D

  final MediaService _mediaServiceClass = MediaService();

  File? imageFile;
  bool _isLoadingGettingImage = false;

  late AnimationController _controller;
  final _tween = IntTween(begin: 0, end: 360);

  late Animation<int> _animation;

  final TextEditingController _assetController = TextEditingController();

  ImageProvider<Object> userImage = AssetImage(snek);

  bool showAvg = false;

  var averageTime = (PrefsHelper().timeElapsedMonday +
          PrefsHelper().timeElapsedTuesday +
          PrefsHelper().timeElapsedWednesday +
          PrefsHelper().timeElapsedThursday +
          PrefsHelper().timeElapsedFriday +
          PrefsHelper().timeElapsedSaturday +
          PrefsHelper().timeElapsedSunday) /
      7;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..addListener(
        () {
          setState(() {});
        },
      );

    _animation = _tween.animate(_controller);
    _controller.repeat();

    _textEditingController1.text = PrefsHelper().accountName;
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    _assetController.dispose();
    _controller.dispose();
    _controllerCenter.dispose(); // Dispose of confetti
    super.dispose();
  }

  Offset _getOffset(int angle, int distance) {
    return Offset.fromDirection(math.pi / 180 * angle, distance.toDouble());
  }

  Future<AppImageSource?> _pickImageSource() async {
    AppImageSource? appImageSource = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          Container(
            color: cardColor,
            child: CupertinoActionSheetAction(
              child: Text(
                'Create Character ₊˚⊹',
                style: TextStyle(color: textColor),
              ),
              onPressed: () {
                showDialog<void>(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: cardColor,
                      insetPadding:
                          EdgeInsets.symmetric(horizontal: 90, vertical: 120),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Randomize!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: mainFont.fontFamily,
                                  color: textColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                FloatingActionButton(
                                  backgroundColor: cardColor,
                                  onPressed: () {
                                    String svg = RandomAvatarString(
                                      DateTime.now().toIso8601String(),
                                      trBackground: true,
                                    );
                                    painters.clear();

                                    painters.add(
                                      RandomAvatar(
                                        DateTime.now().toIso8601String(),
                                        height: 130,
                                        width: 132,
                                      ),
                                    );
                                    _assetController.text = svg;
                                    setState(() {});
                                  },
                                  tooltip: 'Generate',
                                  child: Icon(
                                    Icons.gesture,
                                    color: textColor,
                                  ),
                                ),
                                TextButton(
                                  child: Text(
                                    'Approve ✓',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: mainFont.fontFamily,
                                      color: textColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPressed: () {
                                    PrefsHelper().randomImageChosen = true;
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: cardColor,
            child: CupertinoActionSheetAction(
              child: Text(
                'Take Photo',
                style: TextStyle(color: textColor),
              ),
              onPressed: () => Navigator.of(context).pop(AppImageSource.camera),
            ),
          ),
          Container(
            color: cardColor,
            child: CupertinoActionSheetAction(
              child: Text(
                'Upload From Gallery',
                style: TextStyle(color: textColor),
              ),
              onPressed: () =>
                  Navigator.of(context).pop(AppImageSource.gallery),
            ),
          ),
        ],
        cancelButton: Container(
          color: cardColor,
          child: CupertinoActionSheetAction(
            child: Text(
              'Cancel',
              style: TextStyle(color: textColor),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    );
    if (appImageSource != null) {
      PrefsHelper().randomImageChosen = false;
      _getImage(appImageSource);
    }
  }

  Future _getImage(AppImageSource appImageSource) async {
    setState(() => _isLoadingGettingImage = true);
    final pickedImageFile =
        await _mediaServiceClass.uploadImage(context, appImageSource);
    setState(() => _isLoadingGettingImage = false);

    if (pickedImageFile != null) {
      setState(() => imageFile = pickedImageFile);
    }
  }

  Widget gradientDecor() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
    );
  }

  Widget userIcon(height) {
    return GestureDetector(
      onTap: () {
        _pickImageSource();
      },
      child: CircleAvatar(
        backgroundColor: floatingCircleColors[2],
        radius: height / 9,
        child: (PrefsHelper().randomImageChosen && painters.isNotEmpty)
            ? painters[0]
            : CircleAvatar(
                backgroundColor: floatingCircleColors[2],
                backgroundImage:
                    imageFile == null ? userImage : FileImage(imageFile!),
                radius: height / 10,
              ),
      ),
    );
  }

  Form userName() {
    if (PrefsHelper().accountName == "Name" ||
        PrefsHelper().accountName == "") {
      _textEditingController1.text = "Name";
    }
    return Form(
      key: formKey1,
      child: Column(
        children: [
          GestureDetector(
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                _textEditingController1.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontFamily: mainFont.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(
                      70,
                      MediaQuery.of(context).size.height / 2.5,
                      70,
                      MediaQuery.of(context).size.height / 2.5,
                    ),
                    color: backgroundColor,
                    child: SizedBox(
                      width: 250,
                      child: TextField(
                        controller: _textEditingController1,
                        style: TextStyle(
                          fontFamily: mainFont.fontFamily,
                          color: textColor,
                        ),
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                          labelText: 'Who are you?',
                          contentPadding: EdgeInsets.all(20),
                          hintStyle: TextStyle(
                            color: textColor,
                            fontFamily: mainFont.fontFamily,
                          ),
                          labelStyle: TextStyle(
                            color: textColor,
                            fontFamily: mainFont.fontFamily,
                          ),
                        ),
                        maxLength: 30,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        onSubmitted: (value) {
                          PrefsHelper().accountName = value;
                          _textEditingController1.text = value;
                          _controllerCenter.play(); // Confetti!
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  String timeSpent() {
    int time = PrefsHelper().timeElapsedInLesson;
    String label = " seconds";

    if (time >= 2592000) {
      int months = (time / 2592000).floor();
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
      int days = (time / 86400).floor();
      int hours = ((time / 3600) - (days * 24)).round();
      time = days.round();
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
      int hours = (time / 3600).floor();
      int minutes = ((time / 60) - (hours * 60)).round();

      time = hours.round();
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

  Widget headerChild(String header, String value) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            header,
            style: TextStyle(
              fontFamily: mainFont.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: textColor,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: mainFont.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }

  Widget infoChild(double width, IconData icon, data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: width / 10,
            ),
            Icon(
              icon,
              color: accountPicColor,
              size: 36.0,
            ),
            SizedBox(
              width: width / 20,
            ),
            Text(
              data,
              style: TextStyle(
                fontFamily: mainFont.fontFamily,
                fontSize: 18,
              ),
            )
          ],
        ),
        onTap: () {
          // print('Info Object selected');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        gradientDecor(),
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: textColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Stack(
                children: <Widget>[
                  Positioned(
                    top: _getOffset(_animation.value, 100).dy + 200,
                    left: _getOffset(_animation.value, 200).dx + 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor:
                            floatingCircleColors[1], // <-- Button color
                      ),
                      child:
                          Icon(Icons.nat, color: Colors.transparent, size: .1),
                    ),
                  ),
                  Positioned(
                    top: _getOffset(_animation.value, 100).dy + 100,
                    right: _getOffset(_animation.value, 200).dx + 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor:
                            floatingCircleColors[2], // <-- Button color
                      ),
                      child:
                          Icon(Icons.nat, color: Colors.transparent, size: 40),
                    ),
                  ),
                  Positioned(
                    bottom: _getOffset(_animation.value, 120).dy + 200,
                    right: _getOffset(_animation.value, 100).dx + 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor:
                            floatingCircleColors[0], // <-- Button color
                      ),
                      child: Icon(Icons.nat, color: Colors.transparent),
                    ),
                  ),
                  Positioned(
                    bottom: _getOffset(_animation.value, 100).dy + 100,
                    left: _getOffset(_animation.value, 250).dx + 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor:
                            floatingCircleColors[1], // <-- Button color
                      ),
                      child:
                          Icon(Icons.nat, color: Colors.transparent, size: 70),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          userIcon(height),
                          SizedBox(height: height / 30),
                          userName(),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: accountDarkColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 2.0,
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(width / 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                headerChild(
                                  'Level',
                                  "114",
                                ),
                                // headerChild('Skills', "1205"),
                                headerChild(
                                  'ⴵ Time Spent',
                                  timeSpent(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 100),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: accountDarkColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 2.0,
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                ),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 1.99,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 0,
                                          left: 10,
                                          top: 24,
                                          bottom: 12,
                                        ),
                                        child: LineChart(
                                          showAvg
                                              ? totalData([
                                                  ColorTween(
                                                    begin: mapGradientColors[0],
                                                    end: mapGradientColors[1],
                                                  ).lerp(0.2)!.withOpacity(0.1),
                                                  ColorTween(
                                                    begin: mapGradientColors[0],
                                                    end: mapGradientColors[1],
                                                  ).lerp(0.2)!.withOpacity(0.1),
                                                ], [
                                                  ColorTween(
                                                          begin:
                                                              mapGradientColors[
                                                                  0],
                                                          end:
                                                              mapGradientColors[
                                                                  1])
                                                      .lerp(0.2)!,
                                                  ColorTween(
                                                          begin:
                                                              mapGradientColors[
                                                                  0],
                                                          end:
                                                              mapGradientColors[
                                                                  1])
                                                      .lerp(0.2)!,
                                                ],
                                                  averageTime,
                                                  averageTime,
                                                  averageTime,
                                                  averageTime,
                                                  averageTime,
                                                  averageTime,
                                                  averageTime)
                                              : totalData(
                                                  mapGradientColors
                                                      .map((color) => color
                                                          .withOpacity(0.3))
                                                      .toList(),
                                                  mapGradientColors,
                                                  PrefsHelper()
                                                      .timeElapsedMonday,
                                                  PrefsHelper()
                                                      .timeElapsedTuesday,
                                                  PrefsHelper()
                                                      .timeElapsedWednesday,
                                                  PrefsHelper()
                                                      .timeElapsedThursday,
                                                  PrefsHelper()
                                                      .timeElapsedFriday,
                                                  PrefsHelper()
                                                      .timeElapsedSaturday,
                                                  PrefsHelper()
                                                      .timeElapsedSunday,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      alignment: Alignment.topRight,
                                      child: SizedBox(
                                        width: 34,
                                        height: 34,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.bubble_chart,
                                            color: confettiColors[2],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showAvg = !showAvg;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // TODO: BADGES
                              // Progress bar
                              // you against chat gpt
                              // fix what chat gpt wrote " give me a problem in python to fix"
                              // paragon levels (over leveling) --> once you're done with the levels level up with the chat gpt
                              // Dark mode with different colors
                              // Sections completed (not levels) Separate chatgpt stuff for levels
                              // Pink snake logo --> python wrapped around computer with hats you can earn
                              // snake computer has a little 'help'
                              // snake eating the exterminator bug
                              // 'flame' for one year
                              // 'Exterminator' and 'fix my code'
                              //
                              // name the snake --> print? py? print coding? loop? oop? Oop! Learn to Code, Oroborus, GIL, hash, idle, immutable, lisssssssssssst, lisst, lysst, lambda,
                              // code powered, carnivores, slither,
                              // Leaderboards
                              // infoChild(width / 3, Icons.email, 'email'),
                              // infoChild(width / 3, Icons.call, 'phone number'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        confetti(_controllerCenter),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontFamily: mainFont.fontFamily,
      fontWeight: FontWeight.bold,
      color: textColor,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.left,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontFamily: mainFont.fontFamily,
      fontWeight: FontWeight.bold,
      color: textColor,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 30:
        text = '30';
        break;
      case 60:
        text = '60';
        break;
      default:
        return Container();
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.left,
    );
  }

  LineChartData totalData(
    theseMapColors,
    linearGradientColors,
    monTime,
    tueTime,
    wedTime,
    thuTime,
    friTime,
    satTime,
    sunTime,
  ) {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: mainColor,
            strokeWidth: 1,
          );
        },
        // getDrawingHorizontalLine: (value) {
        //   return FlLine(
        //     strokeWidth: 1,
        //     gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment(0.8, 1),
        //       colors: floatingCircleColors,
        //     ),
        //   );
        // },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 20,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 60,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, monTime),
            FlSpot(1, tueTime),
            FlSpot(2, wedTime),
            FlSpot(3, thuTime),
            FlSpot(4, friTime),
            FlSpot(5, satTime),
            FlSpot(6, sunTime),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: linearGradientColors,
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: theseMapColors,
            ),
          ),
        ),
      ],
    );
  }
}
