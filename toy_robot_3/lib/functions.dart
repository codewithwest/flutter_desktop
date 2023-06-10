import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

//Icon Color Change
theIcon(counter) {
  if (counter == 0) {
    print(counter);
    return const Icon(
      Icons.favorite_outline,
      color: Colors.red,
      size: 30.0,
    );
  } else {
    print(counter);
    return const Icon(
      Icons.favorite,
      color: Colors.red,
      size: 30.0,
    );
  }
}

String response = '';
String name = '';
TextEditingController myController = TextEditingController();

//List for the displayed commands
List questions = [
  "What do you want to name him? ",
  "What Do you want To Do",
];
List responeses = [];

List<dynamic> x = [];
List<dynamic> y = [];

questionDisplay() {
  if (name.isEmpty) {
    return Text(
      questions[0],
      style: const TextStyle(fontSize: 23),
    );
  } else {
    return Text(questions[1]);
  }
}

//change text controller value to list
var command;
//checks for valid commands
commandsChecker(moveDirector) {
  print(direction);
  command = moveDirector.split(" ");
  print(responeses);
  if (command.length == 1) {
    return checkInstruction();
  } else if (command.length == 2) {
    return checkInstructionAndMoves();
  } else {
    questionDisplay();
    myController.clear();
  }
}

checkInstruction() {
  if (command[0] == "right") {
    responeses.add("Turned Right");
    responeses.add("Your new Position is (${xValue()},${yValue()})");
    rightTurn();
  } else if (command[0] == "left") {
    responeses.add("Turned Left");
    responeses.add("Your new Position is (${xValue()},${yValue()})");
    leftTurn();
  } else {
    return;
  }
}

//Check for direction
var yPostive = "goingUp";
var yNegative = "goingDown";
var xPositive = "goingRight";
var xNegative = "goingLeft";

var direction = yPostive;
rightTurn() {
  if (direction == yPostive) {
    return direction = xPositive;
  } else if (direction == xPositive) {
    direction = yNegative;
  } else if (direction == yNegative) {
    direction = xNegative;
  } else if (direction == xNegative) {
    direction = yPostive;
  }
}

leftTurn() {
  if (direction == yPostive) {
    return direction = xNegative;
  } else if (direction == xNegative) {
    direction = yNegative;
  } else if (direction == yNegative) {
    direction = xPositive;
  } else if (direction == xPositive) {
    direction = yPostive;
  }
}

traceBack() {
  var decrement = -int.parse(command[1]);
}

yValue() {
  num newY = 0;
  if (y.isEmpty) {
    return newY;
  } else {
    for (var k = 0; k < y.length; k++) {
      newY = newY + num.parse(y[k]);
    }
  }
  return newY;
}

xValue() {
  num newX = 0;
  if (x.isEmpty) {
    return newX;
  } else {
    for (var k = 0; k < x.length; k++) {
      newX = newX + num.parse(x[k]);
    }
  }
  return newX;
}

sprintValue(value) {
  num newS = 0;
  for (var s = 0; s < int.parse(value) + 1; s++) {
    newS = newS + s;
  }
  return newS;
}

checkInstructionAndMoves() {
  print(command);
  if (responeses.length > 6) {
    responeses.removeRange(0, 2);
  }

  int noOfSteps = int.parse(command[1]);
  if (command[0] == "forward" && noOfSteps is int == true) {
    // checks direction going forward via x axis
    if (direction == xPositive || direction == xNegative) {
      if (direction == xPositive) {
        x.add("${command[1]}");
      } else {
        x.add("-${command[1]}");
      }
      responeses.add("You moved Foward by  ${command[1]}");
      responeses.add("Your new Position is (${xValue()},${yValue()})");
      //checks the direction going forward via y axis
    } else if (direction == yPostive || direction == yNegative) {
      if (direction == yPostive) {
        y.add("${command[1]}");
      } else {
        y.add("-${command[1]}");
      }
      responeses.add("You moved Foward by  ${command[1]}");
      responeses.add("Your new Position is (${xValue()},${yValue()})");
    }
  }

  //Back Moves
  else if (command[0] == "back" && noOfSteps is int == true) {
    if (direction == xPositive || direction == xNegative) {
      if (direction == xPositive) {
        x.add("-${command[1]}");
      } else {
        x.add("${command[1]}");
      }
      responeses.add("You took ${command[1]} backwards ");
      responeses.add("Your new Position is (${xValue()},${yValue()})");
      //checks the direction going forward via y axis
    } else if (direction == yPostive || direction == yNegative) {
      if (direction == yPostive) {
        y.add("-${command[1]}");
      } else {
        y.add("${command[1]}");
      }
      responeses.add("You took ${command[1]} backwards ");
      responeses.add("Your new Position is (${xValue()},${yValue()})");
      traceBack();
    }
  }

  //Srints returns
  else if (command[0] == "sprint" && noOfSteps is int == true) {
    int newCommand = sprintValue(command[1]);
    print(newCommand);
    if (direction == xPositive || direction == xNegative) {
      if (direction == xNegative) {
        x.add("-$newCommand");
      } else {
        x.add("$newCommand");
      }
      for (int cd = 0; cd >= int.parse(command[1]) + 1; cd++) {
        responeses.add("You sprint by ${command[cd]}");
      }
      responeses.add("Your new Position is (${xValue()},${yValue()})");
    } //checks the direction going forward via y axis
    else if (direction == yPostive || direction == yNegative) {
      if (direction == yNegative) {
        y.add("-$newCommand");
      } else {
        y.add("$newCommand");
      }
      for (int cd = int.parse(command[1]); cd == 1; cd--) {
        responeses.add("You sprint by ${command[cd]}");
      }
      responeses.add("Your new Position is (${xValue()},${yValue()})");
    }
  }
}
//Poses the question

showAlertDialog(BuildContext context, int cValue) {
  // set up the buttons
  Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: (() => Navigator.pop(context, true)));
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {},
  );

  // set up the AlertDialog

  AlertDialog alert = AlertDialog(
    iconColor: Colors.black,
    title: Container(
        height: 50,
        width: 50,
        child: const Center(
            child: Text(
          "SHUTTIN DOWN IN",
          style: TextStyle(
            fontSize: 25,
          ),
        ))),
    content: Container(
        height: 80,
        width: 80,
        child: Center(
          child: Text(
            "$cValue",
            style: const TextStyle(
              fontSize: 70,
            ),
          ),
        )),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
