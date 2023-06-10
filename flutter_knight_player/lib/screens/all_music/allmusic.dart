import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/screens/all_music/functions.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

//import 'package:open_file/open_file.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

class AllMusic extends StatefulWidget {
  const AllMusic({super.key});

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {
  TextEditingController dirName = TextEditingController();
  // getDir(dir, setState);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // Assign The list of directories
    Directory dir = Directory('H:');
    getDirectoryChildren(dir, setState);
    // const AsyncSnapshot.waiting();
    // print(allAudioFiles);

    // fullList = getDirectoryChildren(dir, listOfDirectories, setState);
    // print(listOfDirectories);
    // ignore: avoid_print
    // directoryListing.isNotEmpty ? print(directoryListing) : print('Émpty');
    return SafeArea(
      child: Container(
        color: Colors.red,
        child: ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: allAudioFiles.length,
          itemBuilder: (context, index) {
            return (Container(
              margin: const EdgeInsetsDirectional.all(5),
              child: ElevatedButton(
                child: Column(
                  children: [
                    const Icon(
                      Icons.folder,
                      size: 36,
                    ),
                    Text('${allAudioFiles.elementAt(index)}')
                  ],
                ),
                onPressed: () => {},
              ),
            ));
          },
        ),
      ),
      //     child: ListView.builder(
      //         // future: getDirectoryChildren(dir, setState),
      //         builder: (context, AsyncSnapshot snapshot) {
      //   if (!snapshot.hasData) {
      //     // CircularProgressIndicator();
      //     return Center(child: Text('Waiting'));
      //   } else {
      //     return Container(
      //         child: ListView.builder(
      //             itemCount: allAudioFiles.length,
      //             scrollDirection: Axis.horizontal,
      //             itemBuilder: (BuildContext context, int index) {
      //               return Text('${allAudioFiles.elementAt(index)}');
      //             }));
      //   }
      // })
      // )
      // ElevatedButton(
      //     onPressed: (() => {direct.isNotEmpty ? fetchSubDir(direct) : true}),
      //     child: const Icon(Icons.rule)),
      // Text(audioFiles.length.toString()),
      // Expanded(
      //     child: ListView.builder(
      //         scrollDirection: Axis.vertical,
      //         itemCount: audioFiles.length,
      //         itemBuilder: ((context, index) {
      //           return ListTile(
      //               style: ListTileStyle.drawer,
      //               leading: const Icon(
      //                 Icons.label,
      //                 size: 36,
      //               ),
      //               iconColor: const Color.fromRGBO(22, 150, 55, 7),
      //               dense: true,
      //               enabled: true,
      //               contentPadding: const EdgeInsets.all(5),
      //               minVerticalPadding: 10,
      //               hoverColor: const Color.fromRGBO(222, 22, 22, 0.6),
      //               visualDensity: VisualDensity.adaptivePlatformDensity,
      //               enableFeedback: true,
      //               autofocus: true,
      //               trailing: Text(index.toString()),
      //               title: Text(audioFiles.toList()[index].toString()));
      //         },),),),
    );
  }
}
