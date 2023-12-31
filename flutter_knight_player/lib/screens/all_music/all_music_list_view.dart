import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

// ignore: must_be_immutable
class AllMusicListView extends StatefulWidget {
  final Function(String) notifyParent;
  final Function(String) notifyParentfavourites;
  final List allMusicList;
  final List allFavoriteMusicList;
  // ignore: prefer_typing_uninitialized_variables
  var urlToAssign;

  AllMusicListView({
    Key? key,
    required this.allMusicList,
    required this.allFavoriteMusicList,
    required this.urlToAssign,
    required this.notifyParent,
    required this.notifyParentfavourites,
  }) : super(key: key);

  @override
  State<AllMusicListView> createState() => _AllMusicListViewState();
}

class _AllMusicListViewState extends State<AllMusicListView> {
  getSongLength(theUrl) async {
    AudioPlayer player = AudioPlayer();
    var maxDuration;

    Future setAudio() async {
      //play when completed
      var songName = theUrl
          .replaceAll(RegExp(r'\\'), '\\' "\\")
          .replaceAll('File:', '')
          .replaceAll(RegExp(r"'"), '');
      try {
        await player.setSourceUrl(songName);
        print(maxDuration);
        var maxDuration2 = await player.getDuration();
        Timer(const Duration(seconds: 1), () {
          setState(() {
            maxDuration = maxDuration2;
          });
        });
      } catch (err) {
        print(err);
      }
    }

    await setAudio();
    print(maxDuration);
    return maxDuration;
  }

  getlengthViaMetaData(dunb, therl) async {
    try {
      var metadata = await MetadataRetriever.fromFile(File(therl));
      setState(() {
        dunb = metadata.toString();
      });
    } catch (e) {
      print(e);
    }
    print(dunb);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.allMusicList.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.fromLTRB(7, 1, 10, 1),
              child: ElevatedButton(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  onPressed: () => widget
                      .notifyParent(widget.allMusicList[index].toString()),
                  style: AllMusicDecorations().listButtonDecoration(),
                  child: ListTile(
                    minLeadingWidth: 2,
                    iconColor: Colors.green,
                    leading: IconButton(
                      icon: Icon(Icons.favorite,
                          color: widget.allFavoriteMusicList.contains(
                                  widget.allMusicList[index].toString())
                              ? Colors.red
                              : Colors.grey),
                      onPressed: () async => {
                        await widget.notifyParentfavourites(
                            widget.allMusicList[index].toString())
                      },
                    ),
                    title: Text(AllMusicDecorations()
                        .cleanMusicListText(widget.allMusicList[index])),
                    trailing: Text(
                        widget.allMusicList[index].toString().substring(7, 9)),
                  )));
        });
  }
}
