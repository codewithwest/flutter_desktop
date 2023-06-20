import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_knight_player/const/global.dart';
import 'dart:io' as io;

import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:flutter_knight_player/screens/favorites/favourites_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  List<String> allMusicFilesList = [];
  List<String> allFavouritesMusicList = [];
  List allDrivesList = [];
  bool listView = true;
  bool accendingOrder = true;
  bool allMusicLoaded = false;
  String urlToPlay = "";
  void refresh(urlToPass) {
    setState(() => urlToPlay = urlToPass);
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
    _sortAccendingOrder();
    _listOfDrives();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      allMusicFilesList = prefs.getStringList('allMusicFileslist') ?? [];
      allFavouritesMusicList =
          prefs.getStringList('allFavouritesMusicList') ?? [];
      // allMusicFilesList.isEmpty ? check() : true;
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

  listOfAvailableDirectories(availableDrives) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: availableDrives.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.fromLTRB(7, 1, 10, 1),
              child: ElevatedButton(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                onPressed: () => AppGlobalFunctions()
                    .sortDirectoryFiles(availableDrives[index]),
                style: AllMusicDecorations().listButtonDecoration(),
                child: ListTile(
                  minLeadingWidth: 2,
                  iconColor: Colors.green,
                  leading: const Icon(Icons.storage),
                  title: Text(availableDrives[index]
                      .toString()
                      .replaceAll('Directory', 'Drive')
                      .replaceAll("'", '')),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
          child: Container(
        decoration: AllMusicDecorations().songCardDecoration(),
        child: AllFavouriteMusicListView(
            allFavoriteMusicList: allFavouritesMusicList,
            urlToAssign: urlToPlay,
            notifyParent: refresh,
            notifyParentfavourites: _addMusicFileToFavourites),
      )),
    );
  }
}
