// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/commons/commons.dart';
import 'package:test_project/commons/constants.dart';
import 'package:test_project/image_permissions/image_picker_action_sheet.dart';
import 'package:test_project/image_permissions/media_service.dart';
import 'package:test_project/image_permissions/permissions_service.dart';
import 'package:test_project/image_permissions/service_locator.dart';
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

  final _mediaService = getIt<MediaServiceInterface>;
  final _permissionService = getIt<PermissionService>;

  final MediaService _mediaServiceClass = MediaService();

  File? imageFile;
  bool _isLoadingGettingImage = false;

  late AnimationController _controller;
  final _tween = IntTween(begin: 0, end: 360);

  late Animation<int> _animation;

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
      builder: (BuildContext context) => ImagePickerActionSheet(),
    );
    if (appImageSource != null) {
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
    ImageProvider<Object> userImage = AssetImage(snek);
    // userImage = 'assets/elmo_on_fire.png';
    // return AvatarContainer(
    //   isLoading: _isLoadingGettingImage,
    //   onTap: _pickImageSource,
    //   imageFile: imageFile,
    // );

    return GestureDetector(
      onTap: () {
        _pickImageSource();
      },
      child: CircleAvatar(
        backgroundColor: floatingCircleColors[2],
        radius: height / 9,
        child: CircleAvatar(
          backgroundColor: floatingCircleColors[2],
          backgroundImage:
              imageFile == null ? userImage : FileImage(imageFile!),
          // TODO: allow user to get image
          radius: height / 10,

          // onBackgroundImageError: (exception, stackTrace) {
          //   userImage = 'assets/pink_snake.jpg';
          // },
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
            backgroundColor: mainColor,
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
                                child: Text(
                                  "HELLO",
                                  style: TextStyle(
                                    fontFamily: mainFont.fontFamily,
                                    color: textColor,
                                  ),
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
}
