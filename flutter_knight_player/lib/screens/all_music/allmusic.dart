import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:flutter_knight_player/players/allmusicplayer.dart';
import 'package:flutter_knight_player/screens/all_music/all_music_grid_view.dart';
import 'package:flutter_knight_player/screens/all_music/all_music_list_view.dart';
import 'package:flutter_knight_player/screens/all_music/functions.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

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
  bool listView = true;
  String urlToPlay = "";
  void refresh(urlToPass) {
    setState(() => urlToPlay = urlToPass);
  }

  // getDir(dir, setState);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //Get The decoration Class
    var allMusicDecorator = AllMusicDecorations();
    // Diractory to search
    Directory dir = Directory('E:');
    newAsyncMethod() async {
      await sortDirectoryFiles(dir);
      return allFilesList;
    }

    setState(() {
      allFilesList.isEmpty ? newAsyncMethod() : allFilesList;
    });

    changeView() {
      setState(() => listView = !listView);
    }

    return SafeArea(
        child: Column(children: [
      // Top Banner
      Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.fromLTRB(6, 3, 6, 2),
            decoration: allMusicDecorator.topTabDecoration(),
            padding: const EdgeInsets.fromLTRB(5, 5, 2, 2),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 6,
                  child: ListTile(
                    leading: const Icon(Icons.music_note),
                    title: Text("${allFilesList.length} Songs"),
                    trailing: Text('Total Time: ${allFilesList.length * 60}'),
                  ),
                ),
                // Music Contoller
                urlToPlay.isEmpty == true
                    ? Text('')
                    : Expanded(
                        flex: 5,
                        child: AllMusicPlayer(
                          provideUrl: urlToPlay,
                          notifyParent: refresh,
                        )),
                // Refresh music player
                Expanded(
                  child: IconButton(
                    tooltip: listView ? 'Grid' : 'List',
                    icon: const Icon(Icons.replay_outlined),
                    onPressed: () => changeView(),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    tooltip: listView ? 'Grid' : 'List',
                    icon: Icon(listView == false ? Icons.list : Icons.window),
                    onPressed: () => changeView(),
                  ),
                ),
              ],
            ),
          )),

      // All Music Widget Container
      Expanded(
          flex: 7,
          child: listView == true
              ? AllMusicListView(
                  allMusicList: allFilesList,
                  urlToAssign: urlToPlay,
                  notifyParent: refresh,
                )
              : allMusicGridView(context, allFilesList)),
    ]));
  }
}
