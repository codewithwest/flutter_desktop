import 'package:flutter/material.dart';
import 'package:flutter_knight_player/const/colors.dart';

class FoldersDecorations extends KnightColors {
  var foldersNavTabDeco = BoxDecoration(
      color: KnightColors().primaryTabColor(),
      border: Border.all(),
      boxShadow: [
        BoxShadow(
          color: KnightColors().secondaryColor(),
          blurRadius: 5,
          blurStyle: BlurStyle.solid,
        )
      ]);

  var foldersNavIconCont = BoxDecoration(
      border: Border.all(), borderRadius: BorderRadius.circular(100));

  var folderIconShadows = [
    Shadow(color: KnightColors().secondaryColor(), blurRadius: 10)
  ];
}
