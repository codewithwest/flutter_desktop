import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/const/search_algos.dart';
import 'package:flutter_knight_player/decorations/folders_decorations.dart';
import 'package:flutter_knight_player/decorations/folders_helpers.dart';
import '../../const/const_vars.dart';

class Folders extends StatefulWidget {
  final Function(String) notifyParentPlayer;
  const Folders({super.key, required this.notifyParentPlayer});
  @override
  State<Folders> createState() => _FoldersState();
}

TextEditingController dirName = TextEditingController();
var data = File('./music');
var dir = Directory('/');
List? tall;
List existingDir = [];
List alpha = AppGlobalsConst.letters;

//FileSystemEvent f = FileReader() as FileSystemEvent;
List listOfDir = [];
String? searchRes;
var k = DateTime.now();
List? newNames;
List routes = [];
String location = '';
String locationTracker = '';

class _FoldersState extends State<Folders> {
  dirFetch(desiredDir) async {
    if (await desiredDir.existsSync()) {
      var dirToList = await desiredDir.listSync().toList();
      var dirList = [];
      for (var element in dirToList) {
        if (!listOfDir.contains(element)) {
          AppGlobalFunctions()
                  .checkifContains(element, AppGlobalsConst().exceptionFolders)
              ? true
              : dirList.add(element);
        }
      }
      setState(() {
        listOfDir = dirList;
      });
    }
  }

  direPathCreator(stringAtIndex, characta) {
    var newStr = '';
    for (int i = stringAtIndex.length - 2; i >= 0; i--) {
      //print(newStr);
      if (stringAtIndex[i] == characta) {
        //location = newStr;
        return newStr.split('').reversed.join();
      } else {
        newStr += stringAtIndex[i];
      }
    }
  }

//Loops through a list of letters and checks which directories exists
  checksLetters(letter) async {
    for (var l = 0; l < alpha.length; l++) {
      //check matching dir letters
      if (letter == alpha[l] && letter != 'd') {
        letter.toUpperCase();
        //match against dir check
        var dire = Directory('$letter:');
        //if exist add to list of existing dir
        if (dire.existsSync()) {
          //update the list on call
          setState(() {
            //print if dir exist
            existingDir.add(dire);
            dire.list().toList().then((value) => value);
          });
        }
      }
    }
  }

// Check file sytems exists
  checkFileSysExist(alpha) async {
    for (var i = 0; i < alpha.length; i++) {
      await checksLetters(alpha[i]);
    }
  }

  addPath(fileSys) {
    setState(() {
      // Set the route back to default when drive is clicked
      routes = [];
      locationTracker = fileSys
          .replaceAll(RegExp(r'\\\*'), '')
          .replaceAll(RegExp(r'Directory:'), '')
          .replaceAll(RegExp(r"'"), '')
          .toUpperCase();
    });
    routes.add(locationTracker);
  }

  addToPath(String directoryName, cLocal) {
    setState(() {
      routes.add(directoryName);
      locationTracker = routes.join('>');
    });
  }

//Update path text on back button press
  removeFromPath() async {
    print(routes);
    setState(() {
      if (routes.isNotEmpty) {
        routes.removeLast();
        locationTracker = routes.join('>');
        dirFetch(Directory(routes.join('/').trim()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    existingDir.isNotEmpty ? true : checkFileSysExist(alpha);
    var routeLength = routes.isEmpty;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: FoldersDecorations().foldersNavTabDeco,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Icon Container
                  FoldersHelpers()
                      .foldersNavIconContainer(routeLength, removeFromPath),
                  // Route text cont
                  FoldersHelpers().routeTextCont(routeLength, locationTracker)
                ],
              ),
            ),
          ),
          FoldersHelpers().allfoldersTabView(
            existingDir,
            dirFetch,
            listOfDir,
            addPath,
          ),
          FoldersHelpers().directoryListingResolver(
              listOfDir,
              dirFetch,
              AppGlobalFunctions().isAudioFileFormat,
              addToPath,
              direPathCreator,
              locationTracker,
              widget.notifyParentPlayer)
        ],
      ),
    );
  }
}
