import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'dart:io';
// ignore: avoid_print

// import 'package:flutter/material.dart';
Set listOfDirectories = {};

Set direct = {};
Set listOfFiles = {};
Set allAudioFiles = {};
Set checkedDir = {};
Set initiallyExtractedList = {};

toStringtoLower(el, String subStrCheck) {
  return el.toString().toLowerCase().contains(subStrCheck);
}

getDirectoryChildren(directoryToCheck, setState) async {
  // Gets thelist of sub directories and files
  // Converts them to List
  if (directoryToCheck.existsSync()) {
    // await directoryToCheck.list().toSet().then((v) => v);

    initiallyExtractedList.isEmpty
        ? initiallyExtractedList = await directoryToCheck.list().toSet()
        : print('Search Already Done...');
    for (var element in initiallyExtractedList) {
      print(element);
      if (await element.existsSync()) {
        // Check id it is a directory

        if (element.toString().startsWith('D') == true) {
          // print('${toStringtoLower(element, 'recycle')} => $element');
          // Check for unwanted directories
          if (toStringtoLower(element, 'recycle') == true) {
          } else if (toStringtoLower(element, 'system') == true) {
          } else if (toStringtoLower(element, 'boot') == true) {
          } else if (toStringtoLower(element, 'trash') == true) {
          } else {
            listOfDirectories.add(element);
          }
        } else {
          isAudioFile(element.toString()) == true
              ? allAudioFiles.add(element)
              // setState(() => {allAudioFiles.add(element)})
              : print('${element} Not An Audio');
        }
      }
    }
    print(allAudioFiles.length);
    // print(allAudioFiles.length);
    // initiallyExtractedList = {};
    Set listToIterate = listOfDirectories;
    // print(listToIterate);
    listOfDirectories = {};
    print(listToIterate);
    // if (listOfDirectories.isEmpty) {
    for (var elo in listToIterate) {
      // listToIterate.remove(elo);
      getDirectoryChildren(elo, setState);
      // }
    }
    // listOfDirectories
  }
}

isAudioFile(String checkFile) {
  String check = checkFile.replaceAll('File:', '').replaceAll('\'', '').trim();
  // print(t)
  var typeOfFile = lookupMimeType(check);
  // print(ty);
  // print(ty);
  if (typeOfFile == null) {
    return false;
  } else {
    if (typeOfFile.toString().startsWith('audio/')) {
      return true;
    } else if (toStringtoLower(check.toString(), 'm4a')) {
      return true;
    }
  }
}
