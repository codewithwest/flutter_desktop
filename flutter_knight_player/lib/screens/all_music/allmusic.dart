import 'package:flutter/material.dart';
import 'package:flutter_knight_player/screens/all_music/all_music_grid_view.dart';
import 'package:flutter_knight_player/screens/all_music/all_music_list_view.dart';

// ignore: must_be_immutable
class AllMusic extends StatefulWidget {
  final Function(String) notifyParentPlayer;
  final Function(String) notifyParentfavourites;
  final List allMusicList;
  final List allFavoriteMusicList;
  bool listView;
  String urlToPlay;

  AllMusic({
    Key? key,
    required this.allMusicList,
    required this.allFavoriteMusicList,
    required this.listView,
    required this.urlToPlay,
    required this.notifyParentPlayer,
    required this.notifyParentfavourites,
  }) : super(key: key);

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {
  TextEditingController dirName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // changeView() {
  //   setState(() => widget.listView = !widget.listView);
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //Get The decoration Class
    // Diractory to search
    // Directory dir = Directory('G:');

    return SafeArea(
        child: Column(children: [
      // Top Banner
      // All Music Widget Container
      Expanded(
          flex: 7,
          child: widget.listView == true
              ?
              // Is All music loaded
              AllMusicListView(
                  allMusicList: widget.allMusicList,
                  urlToAssign: widget.urlToPlay,
                  notifyParent: widget.notifyParentPlayer,
                  allFavoriteMusicList: widget.allFavoriteMusicList,
                  notifyParentfavourites: widget.notifyParentfavourites,
                )
              : allMusicGridView(
                  context, widget.allMusicList.toSet().toList())),
    ]));
  }
}
