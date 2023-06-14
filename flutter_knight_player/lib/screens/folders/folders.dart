import 'dart:io';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/colors.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:mime/mime.dart';
import '../player.dart';

class Folders extends StatefulWidget {
  const Folders({super.key});

  @override
  State<Folders> createState() => _FoldersState();
}

TextEditingController dirName = TextEditingController();
var data = File('./music');
var dir = Directory('/');
List? tall;
List existingDir = [];
List alpha = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

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
    await desiredDir.list().toList().then((value) {
      listOfDir = value;
    });
    if (desiredDir.existsSync()) {
      setState(() {
        desiredDir.list().toList().then((value) {
          listOfDir = value;
        });
      });
    }
  }

  searchListener() {
    setState(() {
      searchRes = dirName.text.toString();
    });
  }

  getIt(stringAtIndex, characta) {
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

//Loops through a list and checks which directories exists
  checksLetters(letter) {
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

  checkFileSysExist(alpha) {
    for (var i = 0; i < alpha.length; i++) {
      checksLetters(alpha[i]);
    }
  }

  addPath(fileSys) {
    setState(() {
      locationTracker = fileSys
          .replaceAll(RegExp(r'\\\*'), '')
          .replaceAll(RegExp(r'Directory:'), '')
          .replaceAll(RegExp(r"'"), '')
          .toUpperCase();
    });
    routes.add(locationTracker);
  }

  var k = Directory('/');

  addToPath(String directoryName, cLocal) {
    var dN = directoryName.split('');
    setState(() {
      routes.add(directoryName);
      locationTracker = routes.join('/');
    });
  }

//Update path text on back button press
  removeFromPath() {
    setState(() {
      if (routes.isNotEmpty) {
        routes.removeLast();
        locationTracker = routes.join('/');
        dirFetch(Directory(locationTracker.trim()));
      }
    });
  }

  isAudioFileCheck(String checkFile) {
    String check =
        checkFile.replaceAll('File:', '').replaceAll('\'', '').trim();
    //print(check);
    var ty = lookupMimeType(check);

    isAudioFileReturn(String confirm) {
      if (confirm.startsWith('audio/')) {
        return true;
      } else {
        return false;
      }
    }

    if (isAudioFileReturn(ty.toString()) == true) {
      return true;
    } else {
      return false;
    }

    // print(lookupMimeType('C:\Action!\Video\Action 11-6-2022 1-20-26 PM.mp4'));
  }

  @override
  Widget build(BuildContext context) {
    existingDir.isNotEmpty ? true : checkFileSysExist(alpha);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var routeLength = routes.isEmpty;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: KnightColors().primaryTabColor(),
                      border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                          color: KnightColors().secondaryColor(),
                          blurRadius: 5,
                          blurStyle: BlurStyle.solid,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(100)),
                        child: IconButton(
                          onPressed: (() {
                            removeFromPath();
                          }),
                          icon: Icon(
                            routeLength ? Icons.home : Icons.arrow_back,
                            shadows: [
                              Shadow(
                                  color: KnightColors().secondaryColor(),
                                  blurRadius: 10)
                            ],
                          ),
                          iconSize: 35,
                        ),
                      ),
                      Expanded(
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              padding: const EdgeInsets.only(bottom: 3),
                              decoration: routeLength
                                  ? const BoxDecoration()
                                  : BoxDecoration(
                                      border: Border.all(),
                                      color:
                                          const Color.fromRGBO(22, 24, 24, 0.9),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurStyle: BlurStyle.solid,
                                          spreadRadius: .4,
                                          color:
                                              Color.fromRGBO(88, 100, 222, .5),
                                        )
                                      ],
                                    ),
                              child: Text(
                                locationTracker,
                                style: const TextStyle(
                                  fontSize: 22,
                                  overflow: TextOverflow.fade,
                                ),
                              )))
                    ],
                  ))),

          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              color: KnightColors().tabColor(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: existingDir.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsetsDirectional.all(5),
                    child: ElevatedButton(
                      style: AllMusicDecorations().buttonDecoration(),
                      child: Column(
                        children: [
                          Icon(
                            existingDir[index].toString().contains('c:')
                                ? Icons.window_sharp
                                : Icons.drive_file_move,
                            size: 35,
                          ),
                          Text(existingDir[index]
                              .toString()
                              .toUpperCase()
                              .replaceAll(RegExp(r'DIRECTORY:'), 'DRIVE')
                              .replaceAll(RegExp(r"'"), ''))
                        ],
                      ),
                      onPressed: () => {},
                    ),
                  );
                },
              ),
            ),
          ),
          //calls drives if empty
          locationTracker.isEmpty
              ? Expanded(
                  flex: 9,
                  child: ListView.builder(
                      itemCount: existingDir.length,
                      itemBuilder: ((context, index) {
                        bool k =
                            existingDir[index].toString().startsWith('Dir');
                        return ListTile(
                          onTap: () async {
                            if (locationTracker.isEmpty) {
                              addPath(existingDir[index].toString());
                              var km = existingDir[index]
                                  .toString()
                                  .replaceAll(RegExp(r'\\\*'), '')
                                  .replaceAll(RegExp(r'Directory:'), '')
                                  .replaceAll(RegExp(r"'"), '')
                                  .trim()
                                  .toUpperCase();
                              dirFetch(Directory(km));
                            } else {
                              return;
                            }
                          },

                          //trailing: Text(listOfDir[index].toString()),
                          //iconColor: k ? Colors.green : Colors.blue,
                          style: ListTileStyle.drawer,

                          leading: Icon(
                            k ? Icons.folder : Icons.file_copy,
                            size: 36,
                          ),
                          iconColor: k
                              ? const Color.fromRGBO(22, 150, 55, 7)
                              : Colors.amber,
                          dense: true,
                          enabled: true,
                          contentPadding: const EdgeInsets.all(5),
                          minVerticalPadding: 10,
                          hoverColor: const Color.fromRGBO(22, 22, 22, 0.6),
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          enableFeedback: true,
                          title: locationTracker.isNotEmpty
                              ? Text(getIt(listOfDir[index].toString(), '\\'))
                              : Text(existingDir[index]
                                  .toString()
                                  .toUpperCase()
                                  .replaceAll(RegExp(r'DIRECTORY:'), 'DRIVE')
                                  .replaceAll(RegExp(r"'"), '')),
                        );
                      })))
              //If the files and directories available
              : Expanded(
                  flex: 9,
                  child: ListView.builder(
                    itemCount: listOfDir.length,
                    itemBuilder: ((context, index) {
                      bool f = listOfDir[index].toString().startsWith('Dir');
                      bool audioFile =
                          listOfDir[index].toString().startsWith('.mp*');
                      return ListTile(
                        //trailing: Text(listOfDir[index].toString()),
                        iconColor: f ? Colors.green : Colors.blue,
                        style: ListTileStyle.drawer,
                        leading: Icon(f ? Icons.folder : Icons.file_present),
                        dense: true,
                        onTap: () {
                          f
                              ? dirFetch(
                                  Directory(
                                    listOfDir[index]
                                        .toString()
                                        //.replaceAll(RegExp(r'\\'), '')
                                        .replaceAll(RegExp(r'\\\*'), '')
                                        .replaceAll(RegExp(r'Directory:'), '')
                                        .replaceAll(RegExp(r"'"), '')
                                        .replaceAll(RegExp(r'File:'), '')
                                        // .replaceAll(RegExp(r'C:'), '')
                                        .trim(),
                                  ),
                                )
                              :
                              // check if file is playable
                              isAudioFileCheck(listOfDir[index].toString()) ==
                                      true
                                  ? Future.delayed(Duration(milliseconds: 1000),
                                      () {
                                      showModalBottomSheet(
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            double screenWidth =
                                                MediaQuery.of(context)
                                                    .size
                                                    .width;
                                            double screenHeight =
                                                MediaQuery.of(context)
                                                    .size
                                                    .height;

                                            return Player(
                                                provideUrl: listOfDir[index]
                                                    .toString()
                                                    .replaceAll('/', '\\'));
                                          });
                                    })
                                  : true;
                          // : Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Folders(
                          //             provideUrl:
                          //                 listOfDir[index].toString())),
                          //   );

                          f
                              ? addToPath(
                                  getIt(listOfDir[index].toString(), '\\'),
                                  locationTracker)
                              : true;
                        },
                        title: Text(getIt(listOfDir[index].toString(), '\\')),
                      );
                    }),
                  ),
                )
        ],
      ),
    );
  }
}
