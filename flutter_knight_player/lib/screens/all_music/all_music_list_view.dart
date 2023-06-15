import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';

// ignore: must_be_immutable
class AllMusicListView extends StatefulWidget {
  final Function(String) notifyParent;
  final List allMusicList;
  // ignore: prefer_typing_uninitialized_variables
  var urlToAssign;

  AllMusicListView({
    Key? key,
    required this.allMusicList,
    required this.urlToAssign,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<AllMusicListView> createState() => _AllMusicListViewState();
}

class _AllMusicListViewState extends State<AllMusicListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.allMusicList.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.fromLTRB(7, 1, 10, 1),
              child: ElevatedButton(
                  onPressed: () => widget
                      .notifyParent(widget.allMusicList[index].toString()),
                  style: AllMusicDecorations().listButtonDecoration(),
                  child: ListTile(
                    minLeadingWidth: 2,
                    iconColor: Colors.green,
                    leading: const Icon(Icons.music_note),
                    title: Text(AllMusicDecorations()
                        .cleanMusicListText(widget.allMusicList[index])),
                  )));
        });
  }
}
