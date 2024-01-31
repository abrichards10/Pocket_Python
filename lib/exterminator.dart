import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/commons/constants.dart';
import 'package:test_project/models/message.dart';
import 'package:test_project/my_keys.dart';

class Exterminator extends StatefulWidget {
  const Exterminator({super.key});

  @override
  State<Exterminator> createState() => _ExterminatorState();
}

class _ExterminatorState extends State<Exterminator> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> msgs = [];
  bool isTyping = false;
  String prevResponse = "";
  String sentMessage = "";

  void sendMsg(String command, String messageText) async {
    controller.clear();
    try {
      if (command.isNotEmpty) {
        setState(
          () {
            msgs.insert(0, Message(true, messageText));
            isTyping = true;
          },
        );
        scrollController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);
        var response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Authorization": "Bearer $OpenAiKey",
            "Content-Type": "application/json"
          },
          body: jsonEncode(
            {
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": command}
              ]
            },
          ),
        );
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          setState(
            () {
              isTyping = false;
              msgs.insert(
                0,
                Message(
                  false,
                  json["choices"][0]["message"]["content"]
                      .toString()
                      .trimLeft(),
                ),
              );

              prevResponse = msgs[0].msg;
              print("PREV RESPONSE: $prevResponse");
            },
          );
          scrollController.animateTo(0.0,
              duration: const Duration(seconds: 1), curve: Curves.easeOut);
        }
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Some error occurred, please try again!",
        style: TextStyle(
          fontFamily: mainFont.fontFamily,
          color: textColor,
        ),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double boxHeight = screenWidth * .1;

    return Scaffold(
      backgroundColor: backgroundColor,
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
        title: Text(
          "Exterminator",
          style: TextStyle(
            fontFamily: mainFont.fontFamily,
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: screenWidth * .07,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenWidth * .01,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: msgs.length,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * .01,
                  ),
                  child: isTyping && index == 0
                      ? Column(
                          children: [
                            BubbleNormal(
                              text: msgs[0].msg,
                              isSender: true,
                              color: receiveColor,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * .04,
                                top: screenWidth * .01,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Typing...",
                                  style: TextStyle(
                                    color: textColor,
                                    fontFamily: mainFont.fontFamily,
                                    fontSize: screenWidth * .05,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : BubbleNormal(
                          text: msgs[index].msg,
                          isSender: msgs[index].isSender,
                          color:
                              msgs[index].isSender ? receiveColor : sendColor,
                        ),
                );
              },
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * .03),
                      child: Container(
                        width: double.infinity,
                        height: boxHeight,
                        decoration: BoxDecoration(
                          color: accountDarkColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * .04,
                          ),
                          child: TextField(
                            controller: controller,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              color: textColor,
                            ),
                            onSubmitted: (value) {
                              sendMsg(value, value);
                              sentMessage = value;
                            },
                            textInputAction: TextInputAction.send,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter text",
                              hintStyle: TextStyle(
                                fontFamily: mainFont.fontFamily,
                                color: textColor,
                                height: screenWidth * .01,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      sendMsg(sentMessage, sentMessage); // TODO: Change
                    },
                    child: Container(
                      height: screenWidth * .1,
                      width: screenWidth * .1,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.send,
                        color: textColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .03,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * .04,
                  screenWidth * .01,
                  screenWidth * .04,
                  screenWidth * .04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          elevation: 2,
                          color: cardColor,
                          child: Text(
                            "Easy",
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              color: textColor,
                              fontSize: screenWidth * .04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          sendMsg(
                            "Give me an easy practice bug in Python to fix, but don't solve it",
                            "Gimme something easy",
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          color: cardColor,
                          child: Text(
                            "Medium",
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              color: textColor,
                              fontSize: screenWidth * .04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          sendMsg(
                            "Give me an medium difficulty bug in Python to fix, but don't solve it",
                            "Gimme something normal",
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          color: cardColor,
                          child: Text(
                            "Hard",
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              color: textColor,
                              fontSize: screenWidth * .04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          sendMsg(
                            "Give me a hard bug in Python to fix, but don't solve it",
                            "Gimme a hard question",
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          color: cardColor,
                          child: Text(
                            "Legend.",
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              color: textColor,
                              fontSize: screenWidth * .04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          sendMsg(
                            "Give me a super hard python coding question to solve, but don't solve it for me",
                            "I want to be a legend",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * .04,
                  screenWidth * 0,
                  screenWidth * .04,
                  screenWidth * .04,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          elevation: 2,
                          color: cardColor,
                          child: Text(
                            "Fun Fact!",
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              color: textColor,
                              fontSize: screenWidth * .04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          sendMsg(
                            "Give me a fun python coding fact!",
                            "Fun fact?!",
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Card(
                          color: cardColor,
                          child: Text(
                            "Help!",
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              color: textColor,
                              fontSize: screenWidth * .04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          sendMsg(
                            "I give up trying to fix the bug, please tell me the answer to this previous question: $prevResponse",
                            "Help! I can't figure it out :(",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
