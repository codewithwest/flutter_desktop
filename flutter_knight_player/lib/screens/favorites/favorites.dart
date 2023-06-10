import 'package:flutter/material.dart';
import 'dart:io' as io;

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  String? directory;
  List file = [];
  @override
  void initState() {
    super.initState();
    //   _listOfFiles();
  }

/*
  void _listOfFiles() async {
    directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      file = io.Directory("$directory/assets/")
          .listSync(); //use your folder name instead of resume.
    });
  }
*/
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
            physics: const ScrollPhysics(),
            controller: ScrollController(
              keepScrollOffset: true,
            ),
            scrollDirection: Axis.vertical,
            itemCount: 17,
            itemBuilder: ((context, index) {
              return Expanded(
                child: Row(),
              );
            })));
  }
}
