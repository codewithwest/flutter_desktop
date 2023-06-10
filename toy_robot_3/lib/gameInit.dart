import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'functions.dart';

class gameInit extends StatefulWidget {
  const gameInit({super.key});

  @override
  State<gameInit> createState() => _gameInitState();
}

class _gameInitState extends State<gameInit> {
  @override
  var sets = 5;
  initState() {
    setState(
      () {
        if (myController.text.isEmpty) {
          return;
        } else {
          response = myController.text.toLowerCase();
          myController.clear();
        }
        if (response == "off") {
          showAlertDialog(context, sets);
          //exit(1327);
        } else if (name.isEmpty == true) {
          questionDisplay();
          name = response;
          print(name);
        } else {
          questionDisplay();

          commandsChecker(response);
        }
      },
    );
  }

  late Timer timer;
  int _start = 5;

  startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        showAlertDialog(context, _start);
        if (_start == 0) {
          setState(() {
            timer.cancel();
            exit(1327);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 10000),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: questionDisplay(),
            ),
            //Space Creator
            const SizedBox(
              height: 10,
            ),
            DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TextField(
                    mouseCursor: MouseCursor.uncontrolled,
                    enabled: true,
                    controller: myController,
                    onSubmitted: (value) {
                      initState();
                    },
                  ),
                )),
            //Space Creator
            const SizedBox(
              height: 10,
            ),
            Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  //Submit rest Area
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey[300],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: (() => {initState()}),
                      child: const Text("Command"),
                    ),
                  ),
                  //forwad 10
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey[300],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: (() => myController.text = "Forward 10"),
                      child: const Text("Forward 10"),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey[300],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: (() => myController.text = "left"),
                      child: const Text("left"),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey[300],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: (() => myController.text = "right"),
                      child: const Text("right"),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey[300],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: (() => myController.text = "back"),
                      child: const Text("back"),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey[300],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: (() => myController.text = "Sprint 7"),
                      child: const Text("Sprint"),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.grey[300],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: (() {
                        //myController.text = "off";
                        startTimer();
                      }),
                      child: const Text("Power Down"),
                    ),
                  ),
                ])),
            //Space Creator
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 450,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: ListView.builder(
                  semanticChildCount: responeses.length,
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: responeses.length,
                  itemBuilder: ((BuildContext context, index) {
                    return Container(
                      color: Colors.blueGrey[300],
                      margin: const EdgeInsets.all(1),
                      height: 40,
                      child: DecoratedBox(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(230, 70, 13, 80),
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer)
                          ]),
                          child: ListTile(
                            hoverColor: Colors.blue[300],
                            tileColor: Colors.grey[100],
                            leading: Container(
                                color: const Color.fromARGB(20, 14, 109, 36),
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                                width: 60,
                                height: 36,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.green,
                                          blurRadius: 2,
                                          blurStyle: BlurStyle.outer,
                                        ),
                                      ]),
                                  child: Center(
                                      child: Text(
                                    "$name",
                                    style: const TextStyle(fontSize: 20),
                                  )),
                                )),
                            title: Text(responeses[index],
                                style: const TextStyle(fontSize: 20)),
                          )),
                    );
                  }),
                ),
              ),
              //Space Creator
            ),
          ]),
    );
  }
}
