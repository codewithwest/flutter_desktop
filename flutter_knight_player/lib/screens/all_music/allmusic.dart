import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:flutter_knight_player/players/allmusicplayer.dart';
import 'package:flutter_knight_player/screens/all_music/all_music_grid_view.dart';
import 'package:flutter_knight_player/screens/all_music/all_music_list_view.dart';
import 'package:flutter_knight_player/screens/all_music/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> allMusicFilesList = [];
  bool listView = true;
  bool accendingOrder = true;
  String urlToPlay = "";
  void refresh(urlToPass) {
    setState(() => urlToPlay = urlToPass);
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
    _sortAccendingOrder();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Directory dir = Directory('C:');
    // allMusicFilesList.isEmpty ? await sortDirectoryFiles(dir) : true;
    setState(() {
      allMusicFilesList = prefs.getStringList('allMusicFileslist') ?? [];
    });
  }

  void _addMusicFilesToList(allSearchedfileList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var element in allSearchedfileList) {
        allMusicFilesList.contains(element.toString())
            ? true
            : allMusicFilesList.add(element.toString());
      }
      prefs.setStringList('allMusicFileslist', allMusicFilesList);
    });
  }

  void _resetCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      allMusicFilesList = [];
      prefs.setStringList('allMusicFileslist', allMusicFilesList);
    });
  }

  _getAllMusicFilesFromProvidedDrive(driveLetter) async {
    Directory dir = Directory("$driveLetter:");
    await sortDirectoryFiles(dir);
    _addMusicFilesToList(allFilesList);
    setState(() {
      allFilesList.toSet().toList();
    });
  }

  _sortAccendingOrder() {
    setState(() {
      allMusicFilesList.sort((a, b) => a.length.compareTo(b.length));
      accendingOrder = true;
    });
  }

  _sortDecendingOrder() {
    setState(() {
      allMusicFilesList.sort((a, b) => b.length.compareTo(a.length));
      accendingOrder = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //Get The decoration Class
    var allMusicDecorator = AllMusicDecorations();
    // Diractory to search
    // Directory dir = Directory('G:');

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
                  flex: 3,
                  child: ListTile(
                    leading: const Icon(Icons.music_note),
                    title: Text("${allMusicFilesList.length} Songs"),
                    // trailing:
                    //     Text('Total Time: ${allMusicFilesList.length * 60}'),
                  ),
                ),
                // Music Contoller
                urlToPlay.isEmpty == true
                    ? const Text('')
                    : Expanded(
                        flex: 5,
                        child: AllMusicPlayer(
                          provideUrl: urlToPlay,
                          notifyParent: refresh,
                        )),

                // Sort in AccendingOrder
                Expanded(
                  child: IconButton(
                    tooltip:
                        accendingOrder ? 'Decending Order' : 'Accending Order',
                    icon: Icon(accendingOrder
                        ? Icons.sort_by_alpha
                        : Icons.sort_by_alpha_rounded),
                    onPressed: () => accendingOrder
                        ? _sortDecendingOrder()
                        : _sortAccendingOrder(),
                  ),
                ),
                // Refresh music player
                Expanded(
                  child: IconButton(
                    tooltip: 'reload Songs',
                    icon: const Icon(Icons.add),
                    onPressed: () => _getAllMusicFilesFromProvidedDrive('H'),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    tooltip: 'Reset All Music',
                    icon: const Icon(Icons.replay_outlined),
                    onPressed: () => _resetCounter(),
                  ),
                ),

                Expanded(
                  child: Text(allMusicFilesList.length.toString()),
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
                  allMusicList: allMusicFilesList.toSet().toList(),
                  urlToAssign: urlToPlay,
                  notifyParent: refresh,
                )
              : allMusicGridView(context, allMusicFilesList.toSet().toList())),
    ]));
  }
}
