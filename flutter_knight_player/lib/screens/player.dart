import 'package:mime/mime.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
//import 'package:time_formatter/time_formatter.dart';

class Player extends StatefulWidget {
  const Player({
    required this.provideUrl,
    Key? key,
  }) : super(key: key);
  final String provideUrl;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
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

    player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        maxDuration = newDuration;
      });
    });
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
    widget.provideUrl.isEmpty ? true : await player.play(UrlSource(songName));

    // .play(UrlSource('assets/music/Love_Doctor_(lyrics)-_Romain_Virgo.mp3'));
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
      //margin: EdgeInsets.fromLTRB(width / 2, height / 2, 2, height / 11),
      height: height / 2.5,
      //width: width / 10,
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(),
              boxShadow: const [BoxShadow(color: Colors.red)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
                width: 5,
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    width: width / 2,
                    height: height / 1.2,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      border: Border.all(),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          blurStyle: BlurStyle.solid,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.all(5),
                height: 20,
                width: 320,
                //child: Text((position.inSeconds.toDouble()).toString()),
                child: Slider(
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
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(position.inSeconds.toString()),
                Text((maxDuration.inSeconds.toDouble() -
                        position.inSeconds.toDouble())
                    .toString()),
              ]),
              //Controls
              Expanded(
                  child: SizedBox(
                      width: width / 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: (() => {
                                  if (isPlaying) {player.stop()}
                                }),
                            icon: const Icon(Icons.stop),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.skip_previous_rounded),
                          ),
                          IconButton(
                            onPressed: () async => {
                              if (isPlaying)
                                {player.pause()}
                              else
                                {player.resume()}
                            },
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.skip_next),
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
