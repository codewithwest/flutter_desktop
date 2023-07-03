import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:flutter_knight_player/screens/dashboard/dashboard_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/search_algos.dart';
import '../../players/allmusicplayer.dart';
import '../all_music/add_folders_dialog.dart';

class DashBoard extends StatefulWidget {
  final Function notifyParentTheme;
  const DashBoard({
    Key? key,
    required this.notifyParentTheme,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  TextEditingController dirName = TextEditingController();
  List<String> allMusicFilesList = [];
  List<String> allFavouritesMusicList = [];
  List allDrivesList = [];
  bool listView = true;
  bool IsPlaying = false;
  AudioPlayer player = AudioPlayer();
  bool accendingOrder = true;
  bool allMusicLoaded = false;
  String urlToPlay = "";
  int _selectedIndex = 0;
  late List screens;

  @override
  void initState() {
    super.initState();
    _loadCounter();
    _sortAccendingOrder();
    _listOfDrives();
  }

  check() async {
    var ts = await AppGlobalFunctions().getAllMusicFilesFromAllDrives();
    setState(() {
      _addMusicFilesToList(ts);
      allMusicLoaded = true;
    });
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      allMusicFilesList = prefs.getStringList('allMusicFileslist') ?? [];
      allFavouritesMusicList =
          prefs.getStringList('allFavouritesMusicList') ?? [];
    });
  }

  _addMusicFilesToList(allSearchedfileList) async {
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

  _addMusicFileToFavourites(clickedFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      allFavouritesMusicList.contains(clickedFile.toString())
          ? allFavouritesMusicList.remove(clickedFile.toString())
          : allFavouritesMusicList.add(clickedFile.toString());

      prefs.setStringList('allFavouritesMusicList', allFavouritesMusicList);
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
    var returnedAllFilesList =
        await AppGlobalFunctions().sortDirectoryFiles(dir);
    await _addMusicFilesToList(returnedAllFilesList);
    setState(() {
      returnedAllFilesList;
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

  void _listOfDrives() async {
    var newListOfDrives = await AppGlobalFunctions().getAllDrivesOnSystem();
    setState(() {
      for (var drive in newListOfDrives) {
        allDrivesList.add(drive);
      }
    });
  }

  changeView() {
    setState(() => listView = !listView);
  }

  void playSong(urlToPass) {
    setState(() {
      // urlToPlay.isNotEmpty ? IsPlaying = true : IsPlaying = false;
      urlToPlay = urlToPass;
    });
  }

  void screenChangeTap(selectedindex, pos) {
    setState(() {
      _selectedIndex = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    screens = DashBoardHelpers().screens(
      allMusicFilesList,
      allFavouritesMusicList,
      listView,
      urlToPlay,
      playSong,
      _addMusicFileToFavourites,
      widget.notifyParentTheme,
    );

    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        _selectedIndex == 0 ? true : screenChangeTap(_selectedIndex, 0);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: width < 800
            ? DashBoardHelpers()
                .bottomNavBarHandler(screenChangeTap, _selectedIndex)
            : null,
        body: Column(children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.fromLTRB(6, 3, 6, 2),
              decoration: AllMusicDecorations().topTabDecoration(),
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
                  urlToPlay.isEmpty
                      ? const Text('')
                      : Expanded(
                          flex: 5,
                          child: AllMusicPlayer(
                            provideUrl: urlToPlay,
                            notifyParent: playSong,
                            isPlaying: IsPlaying,
                            playersList: allMusicFilesList,
                          )),
                  // Sort in AccendingOrder
                  Expanded(
                    child: IconButton(
                      tooltip: accendingOrder
                          ? 'Decending Order'
                          : 'Accending Order',
                      icon: Icon(accendingOrder
                          ? Icons.sort_by_alpha
                          : Icons.sort_by_alpha_rounded),
                      onPressed: () => accendingOrder
                          ? _sortDecendingOrder()
                          : _sortAccendingOrder(),
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
                  Expanded(
                    child: IconButton(
                      tooltip: 'Add Music To Library',
                      icon: const Icon(Icons.add_box),
                      onPressed: () => loadDrivesDialog(context, allDrivesList,
                          _getAllMusicFilesFromProvidedDrive),
                    ),
                  ),
                  // showMyDialog(context)
                ],
              ),
            ),
          ),

          // Navigation bar container and handler
          Expanded(
            flex: 6,
            child: Row(
              children: [
                if (width > 800)
                  DashBoardHelpers()
                      .navigationRailHelper(screenChangeTap, _selectedIndex),
                Expanded(child: screens[_selectedIndex])
              ],
            ),
          ),
          //this is optional)
        ]),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
