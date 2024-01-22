import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/commons/commons.dart';
import 'package:test_project/commons/constants.dart';

class CommentsLesson extends StatefulWidget {
  const CommentsLesson({super.key});

  @override
  State<CommentsLesson> createState() => CommentsLessonState();
}

class CommentsLessonState extends State<CommentsLesson> {
  late ConfettiController _controllerCenter; // CONFETTI! :D

  ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  bool _correctAnswer = false;

  final _stopwatch = Stopwatch(); // keep track of time spent on lesson

  @override
  void initState() {
    _stopwatch.start();
    _textEditingController1.text = PrefsHelper().comment1;
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    _scrollController = ScrollController(
        initialScrollOffset: PrefsHelper().currentCommentScroll);
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

  Widget showNextButton(double thisScroll) {
    return ElevatedButton(
      onPressed: () {
        PrefsHelper().currentCommentScroll = thisScroll;
        _scrollController.animateTo(
          PrefsHelper().currentCommentScroll,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 800),
        );
        _correctAnswer = false;
        setState(() {});
        FocusScope.of(context).unfocus();
      },
      style: ElevatedButton.styleFrom(backgroundColor: mainColor),
      child: Text(
        "next >",
        style: TextStyle(
          fontFamily: mainFont.fontFamily,
          fontWeight: FontWeight.w600,
          color: textColor,
          fontSize: MediaQuery.of(context).size.width / 26,
        ),
      ),
    );
  }

  commentSubmitted1(value) {
    PrefsHelper().comment1 = value;
    _textEditingController1.text = value;
    if (validateComment1(value)) {
      _controllerCenter.play(); // Confetti!
      showCorrectDialog(context);
      _correctAnswer = true;
      if (!PrefsHelper().comment1AlreadyDone) {
        PrefsHelper().comment1AlreadyDone = true;
        PrefsHelper().numberOfCommentActivitiesDone =
            PrefsHelper().numberOfCommentActivitiesDone + 1;
      }
      setState(() {});
    } else {
      incorrectAnswerPopup(context);
    }
  }

  Form commentForm1() {
    return Form(
      key: _formKey1,
      child: Column(
        children: [
          TextField(
            controller: _textEditingController1,
            style: TextStyle(
              fontFamily: mainFont.fontFamily,
              color: textColor,
            ),
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

  _commentDescription() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          40, MediaQuery.of(context).size.height / 2, 40, 0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: cardColor,
        ),
        child: Text(
          "Comments are used for: \n\t - Explaining code \n\t - Making code more readable \n\t - Preventing execution for testing \n\nEx:\n\t\t#This prints out the name of my pet snake!\n\t\tprint(\"Sir-Slithers-A-Lot\")",
          style: TextStyle(
              fontFamily: mainFont.fontFamily,
              color: textColor,
              fontSize: 18,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w300),
        ),
      ),
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
                  explanationText("# This is a comment", context),
                  commentForm1(),
                  const SizedBox(
                    height: 100,
                  ),
                  explanationText(
                      "\"\"\" \n\tThis is also a comment just so you know\n\"\"\"",
                      context),
                  doneButton(context, _stopwatch),
                ],
              ),
            ),
          ],
        ),
        _correctAnswer ? showNextButton(220) : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          appBar: lessonAppBar(
            context,
            _stopwatch,
            "Comments",
          ),
          body: mainLesson(),
        ),
        _correctAnswer ? _commentDescription() : Container(),
        confetti(_controllerCenter),
      ],
    );
  }
}
