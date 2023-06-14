import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
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

    allFilesList.isEmpty ? newAsyncMethod() : allFilesList;

    return SafeArea(
        child: Column(children: [
      Container(
        margin: const EdgeInsets.fromLTRB(6, 3, 6, 2),
        decoration: allMusicDecorator.topTabDecoration(),
        height: height / 10.5,
        padding: const EdgeInsets.fromLTRB(5, 5, 2, 2),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ElevatedButton(
              child: Column(
                children: [
                  const Icon(
                    Icons.audio_file,
                    size: 36,
                  ),
                  Text(allFilesList.length.toString())
                ],
              ),
              onPressed: () => {},
            ),
          ],
        ),
      ),
      Expanded(
        flex: 9,
        child: GridView.builder(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 800
                ? MediaQuery.of(context).size.width < 500
                    ? MediaQuery.of(context).size.width < 300
                        ? 1
                        : 2
                    : 3
                : 5,
            childAspectRatio: 1,
            crossAxisSpacing: 2,
          ),
          itemCount: allFilesList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: allMusicDecorator.songCardDecoration(),
              margin: const EdgeInsetsDirectional.all(3),
              child: ElevatedButton(
                style: allMusicDecorator.buttonDecoration(),
                child: Column(
                  children: [
                    Expanded(
                        flex: 9,
                        child: Container(
                          decoration: allMusicDecorator.imageContainer(),
                          margin: const EdgeInsets.all(2),
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          width: width,
                          decoration: allMusicDecorator.textContainer(),
                          margin: const EdgeInsets.all(2),
                          child: Center(
                              child: allMusicDecorator.childText(
                                  allFilesList[index], context)),
                        ))
                  ],
                ),
                onPressed: () async {
                  var metadata = await MetadataRetriever.fromFile(
                      (File(allFilesList[index].toString())));
                  try {
                    print(metadata);
                  } catch (e) {
                    print(e);
                  }

// String? trackName = metadata.trackName;
// List<String>? trackArtistNames = metadata.trackArtistNames;
// String? albumName = metadata.albumName;
// String? albumArtistName = metadata.albumArtistName;
// int? trackNumber = metadata.trackNumber;
// int? albumLength = metadata.albumLength;
// int? year = metadata.year;
// String? genre = metadata.genre;
// String? authorName = metadata.authorName;
// String? writerName = metadata.writerName;
// int? discNumber = metadata.discNumber;
// String? mimeType = metadata.mimeType;
// int? trackDuration = metadata.trackDuration;
// int? bitrate = metadata.bitrate;
// Uint8List? albumArt = metadata.albumArt;
                },
              ),
            );
          },
        ),
      ),
    ]));
  }
}
