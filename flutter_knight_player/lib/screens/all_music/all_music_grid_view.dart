import 'dart:io';
import '../../decorations/decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

allMusicGridView(context, allMusicListProp) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return GridView.builder(
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
    itemCount: allMusicListProp.length,
    itemBuilder: (context, index) {
      return Container(
        decoration: AllMusicDecorations().songCardDecoration(),
        // AllMusicDecorations().songCardDecoration(),
        margin: const EdgeInsetsDirectional.all(3),
        child: ElevatedButton(
          style: AllMusicDecorations().buttonDecoration(),
          child: Column(
            children: [
              Expanded(
                  flex: 9,
                  child: Container(
                    decoration: AllMusicDecorations().imageContainer(),
                    margin: const EdgeInsets.all(2),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    width: width,
                    decoration: AllMusicDecorations().textContainer(),
                    margin: const EdgeInsets.all(2),
                    child: Center(
                        child: AllMusicDecorations()
                            .childText(allMusicListProp[index], context)),
                  ))
            ],
          ),
          onPressed: () async {
            var metadata = await MetadataRetriever.fromFile(
                (File(allMusicListProp[index].toString())));
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
  );
}
