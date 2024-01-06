// ignore_for_file: prefer_const_constructors

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/commons/commons.dart';

class CommentsLesson extends StatefulWidget {
  const CommentsLesson({super.key});

  @override
  State<CommentsLesson> createState() => CommentsLessonState();
}

class CommentsLessonState extends State<CommentsLesson> {
  late ConfettiController _controllerCenter; // CONFETTI! :D

  ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController1 = TextEditingController();

  final mainFont = GoogleFonts.comicNeue();
  final mainColor = const Color.fromARGB(255, 252, 221, 253);
  final formKey1 = GlobalKey<FormState>();

  bool correctAnswer = false;

  final stopwatch = Stopwatch(); // keep track of time spent on lesson

  @override
  void initState() {
    stopwatch.start();
    _textEditingController1.text = PrefsHelper().comment_1;

    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    _scrollController =
        ScrollController(initialScrollOffset: PrefsHelper().currentScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose(); // Dispose of confetti
    _textEditingController1.dispose();
    super.dispose();
  }

  bool validateComment1(String userInput) {
    if (userInput.startsWith("#")) {
      return true;
    } else {
      return false;
    }
  }

  bool validateComment2(String userInput) {
    print("GOT HERE");
    final compare = RegExp(r'["""]["""]', caseSensitive: false);

    if (compare.hasMatch(userInput)) {
      return true;
    } else {
      return false;
    }
  }

  void _showCorrectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(milliseconds: 600), () {
          Navigator.of(context).pop(true);
        });
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 255, 208, 252)),
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text(
                'Correct!',
                style: GoogleFonts.comicNeue(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        );
      },
    );
  }

  void _incorrectAnswerPopup() {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(milliseconds: 600), () {
          Navigator.of(context).pop(true);
        });

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 255, 208, 252)),
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Text(
                'Try again!',
                style: GoogleFonts.comicNeue(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget showNextButton(double thisScroll) {
    return ElevatedButton(
      onPressed: () {
        PrefsHelper().currentScroll = thisScroll;
        _scrollController.animateTo(
          PrefsHelper().currentScroll,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 800),
        );
        correctAnswer = false;
        setState(() {});
        FocusScope.of(context).unfocus();
      },
      child: Text(
        "next >",
        style: GoogleFonts.ptMono(
          textStyle: TextStyle(
              color: Color.fromARGB(255, 104, 63, 101),
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width / 26),
        ),
      ),
    );
  }

  Text commentText1() {
    return Text(
      "# This is a comment",
      style: GoogleFonts.ptMono(
        textStyle: TextStyle(
            // fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width / 24),
      ),
    );
  }

  Text commentText2() {
    return Text(
      "\"\"\" \n\tThis is also a comment\n\"\"\"",
      style: GoogleFonts.ptMono(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 24,
        ),
      ),
    );
  }

  commentSubmitted1(value) {
    PrefsHelper().comment_1 = value;
    _textEditingController1.text = value;
    if (validateComment1(value)) {
      _controllerCenter.play(); // Confetti!
      _showCorrectDialog();
      correctAnswer = true;
      setState(() {});
    } else {
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 600), () {
            Navigator.of(context).pop(true);
          });

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 255, 208, 252)),
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Text(
                  'Try again!',
                  style: GoogleFonts.comicNeue(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  InputDecoration submitDecoration(String hintText) {
    return InputDecoration(
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Icon(
                Icons.arrow_circle_right_outlined,
                color: Color.fromARGB(255, 255, 164, 249),
              ),
            ),
            onTap: () {},
          ),
        ),
      ),
      hintText: hintText,
      labelText: '',
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 201, 152, 198)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 255, 164, 249)),
      ),
    );
  }

  Form commentForm1() {
    return Form(
      key: formKey1,
      child: Column(
        children: [
          TextField(
            controller: _textEditingController1,
            style: mainFont,
            decoration: submitDecoration("Type a comment"),
            autofocus: false,
            maxLength: 30,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onSubmitted: (value) {
              commentSubmitted1(value);
            },
          ),
        ],
      ),
    );
  }

  Widget doneButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          label: Text(
            "Done!", //  ₊˚⊹♡",
            style: TextStyle(
              fontFamily: GoogleFonts.comicNeue().fontFamily,
              fontWeight: FontWeight.w800,
              height: 5,
              color: Color.fromARGB(255, 255, 164, 249),
            ),
          ),
          icon: Icon(
            Icons.arrow_circle_right_outlined,
            color: Color.fromARGB(255, 255, 164, 249),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget mainLesson() {
    // PrefsHelper().currentScroll = 0;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(40),
                children: [
                  commentText1(),
                  commentForm1(),
                  SizedBox(
                    height: 100,
                  ),
                  commentText2(),
                  doneButton(),
                ],
              ),
            ),
          ],
        ),
        correctAnswer ? showNextButton(220) : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: lessonAppBar(context, stopwatch, "Comments"),
      body: Stack(
        children: <Widget>[
          confetti(_controllerCenter),
          mainLesson(),
        ],
      ),
    );
  }
}
