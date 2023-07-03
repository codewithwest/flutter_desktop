import 'dart:io';
import 'package:flutter/material.dart';
import 'decoration.dart';
import 'folders_decorations.dart';

class FoldersHelpers extends FoldersDecorations {
  // Contains the Icon On the Naav Tab
  foldersNavIconContainer(
    routelengthChecker,
    pathRemoveFunc,
  ) =>
      Container(
        margin: const EdgeInsets.all(5),
        decoration: FoldersDecorations().foldersNavIconCont,
        child: Center(
          child: routelengthChecker
              ? const SizedBox()
              : IconButton(
                  onPressed: (() => pathRemoveFunc()),
                  icon: Icon(Icons.arrow_back,
                      shadows: FoldersDecorations().folderIconShadows),
                  iconSize: 22,
                ),
        ),
      );
// Container the Route your at
  routeTextCont(routelengthChecker, tabLocationTracker) => Expanded(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: const EdgeInsets.only(bottom: 3),
          decoration: routelengthChecker
              ? const BoxDecoration()
              : const BoxDecoration(
                  color: Color.fromARGB(142, 35, 2, 168),
                ),
          child: Text(
            tabLocationTracker,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      );

  allfoldersTabView(
    listOfExistingDirs,
    getDirFunc,
    dirList,
    addToPath,
  ) =>
      Expanded(
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          // color: KnightColors().tabColor(),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listOfExistingDirs.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsetsDirectional.all(2),
                child: ElevatedButton(
                  style: AllMusicDecorations().buttonDecoration(),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        listOfExistingDirs[index].toString().contains('c:')
                            ? Icons.window_sharp
                            : Icons.drive_file_move,
                        size: 25,
                      ),
                      Text(listOfExistingDirs[index]
                          .toString()
                          .toUpperCase()
                          .replaceAll(RegExp(r'DIRECTORY:'), 'DRIVE')
                          .replaceAll(RegExp(r"'"), ''))
                    ],
                  )),
                  onPressed: () {
                    addToPath(listOfExistingDirs[index].toString());
                    getDirFunc(listOfExistingDirs[index]);
                  },
                ),
              );
            },
          ),
        ),
      );

  directoryListingResolver(
    directoryList,
    getDirFunc,
    audioFileChecker,
    addToPath,
    pathcreatorFunc,
    locationTracker,
    playMusicFunc,
  ) =>
      Expanded(
        flex: 9,
        child: ListView.builder(
          itemCount: directoryList.length,
          itemBuilder: ((context, index) {
            bool folder = directoryList[index].toString().startsWith('Dir');
            return ListTile(
              //trailing: Text(listOfDir[index].toString()),
              iconColor: folder ? Colors.blue : Colors.green,
              style: ListTileStyle.drawer,
              leading: Icon(folder ? Icons.folder : Icons.audiotrack),
              dense: true,
              onTap: () {
                folder
                    ? getDirFunc(
                        Directory(
                          directoryList[index]
                              .toString()
                              .replaceAll(RegExp(r'\\\*'), '')
                              .replaceAll(RegExp(r'Directory:'), '')
                              .replaceAll(RegExp(r"'"), '')
                              .replaceAll(RegExp(r'File:'), '')
                              .trim(),
                        ),
                      )
                    :
                    // check if file is playable
                    audioFileChecker(directoryList[index].toString()) == true
                        ? playMusicFunc(directoryList[index]
                            .toString()
                            .replaceAll('/', '\\'))
                        : true;
                folder
                    ? addToPath(
                        pathcreatorFunc(directoryList[index].toString(), '\\'),
                        locationTracker)
                    : true;
              },
              title:
                  Text(pathcreatorFunc(directoryList[index].toString(), '\\')),
            );
          }),
        ),
      );
}
