import 'package:flutter_knight_player/decorations/colors.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:mime/mime.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
//import 'package:time_formatter/time_formatter.dart';

class AllMusicPlayer extends StatefulWidget {
  final Function(String) notifyParent;

  const AllMusicPlayer({
    required this.provideUrl,
    required this.notifyParent,
    Key? key,
  }) : super(key: key);
  final String provideUrl;

  @override
  State<AllMusicPlayer> createState() => _PlayerState();
}

class _PlayerState extends State<AllMusicPlayer> {
  //String provideUrl;
  bool isPlaying = false;
  AudioPlayer player = AudioPlayer();
  Duration duration = Duration.zero;
  Duration maxDuration = Duration.zero;
  Duration position = Duration.zero;

  //String get provideUrl => null;

  @override
  void initState() {
    super.initState();

    print(setAudio());

    //listen to states playing paused and stopped
// Check if the play or pause button is played
    player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });
    // List to the seekd dutation
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        maxDuration = newDuration;
      });
    });
    // Set The position to the new position
    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    //play when completed
    var songName = widget.provideUrl
        .replaceAll(RegExp(r'\\'), '\\' "\\")
        .replaceAll('File:', '')
        .replaceAll(RegExp(r"'"), '');
    player.setReleaseMode(ReleaseMode.loop);
    player.onSeekComplete;
    print(player.getDuration());
    if (widget.provideUrl.isNotEmpty) {
      try {
        await player.play(UrlSource(songName));
      } catch (e) {
        widget.notifyParent("");
      }
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: KnightColors().secondaryColor(),
          // border: Border.all(),
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: KnightColors().primaryTabColor(),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(4),
                width: width / 2,
                height: height / 1.2,
                child: Center(
                    child: Text(AllMusicDecorations()
                        .cleanMusicListText(widget.provideUrl))),
              )),
          Expanded(
            // flex: 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      style: const TextStyle(fontSize: 15),
                      position.inSeconds.toString()),
                  Slider(
                      activeColor: Colors.green,
                      min: 0.0,
                      max: maxDuration.inSeconds.ceilToDouble(),
                      onChanged: (double val) async {
                        int seekval = val.round();
                        var result =
                            await player.seek(Duration(seconds: seekval));
                        //seek successful
                        position = result as Duration;
                        //play audio if was paused
                        await player.resume();
                      },
                      value: double.parse(position.inSeconds.toString())),
                  Text(
                      style: const TextStyle(fontSize: 15),
                      (maxDuration.inSeconds.toDouble() -
                              position.inSeconds.toDouble())
                          .toString()),
                ]),
          ),
          //Controls
          Expanded(
              flex: 1,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: (() {
                      // if (isPlaying) {
                      widget.notifyParent("");
                      player.stop();
                      // }
                    }),
                    icon: const Icon(
                      Icons.stop,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () async => {
                      if (isPlaying) {player.pause()} else {player.resume()}
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next,
                      size: 20,
                    ),
                  ),
                ],
              )))
        ],
      ),
    );
  }
}
