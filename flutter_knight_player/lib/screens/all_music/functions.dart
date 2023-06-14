import 'dart:io';

import 'package:mime/mime.dart';
// ignore: avoid_print

// import 'package:flutter/material.dart';

toStringtoLower(el, String subStrCheck) {
  return el.toString().toLowerCase().contains(subStrCheck);
}

var _directory = Directory('E:');

var allDirectoryList = [];
var allFilesList = [];

sortDirectoryFiles(directoryToCheck) {
  var directoryList;
  if (_directory.existsSync()) {
    try {
      directoryList = directoryToCheck.listSync().toList();
      for (var element in directoryList) {
        if (element.toString().contains('Directory:')) {
          if (toStringtoLower(element, 'system') ||
              toStringtoLower(element, 'program files') ||
              toStringtoLower(element, 'programdata') ||
              toStringtoLower(element, 'python') ||
              toStringtoLower(element, 'windows') ||
              toStringtoLower(element, 'apps') ||
              toStringtoLower(element, 'backups') ||
              toStringtoLower(element, 'dell') ||
              toStringtoLower(element, 'drivers') ||
              toStringtoLower(element, 'iteadmin') ||
              toStringtoLower(element, 'intel') ||
              toStringtoLower(element, 'onedrivetemp')) {
          } else {
            allDirectoryList.add(element);
          }
        } else {
          isAudioFileFormat(element.toString())
              ? allFilesList.add(element)
              : false;
        }
      }
      // dig deeper
      List listOfCurrentDir = [];
      listOfCurrentDir = allDirectoryList;
      allDirectoryList = [];
      if (listOfCurrentDir.isNotEmpty) {
        for (var folders in listOfCurrentDir) {
          sortDirectoryFiles(folders);
        }
      }
    } catch (err) {
      print('error');
      print(err);
    }
  }
  print(allFilesList);
}

isAudioFileFormat(String checkFile) {
  var fileTypes = [
    'm4a',
    'mp3',
    'wav',
    'flac',
    'aac',
    'alac',
    'aiff',
    'dsd',
    'pcm'
  ];
  String cleanedStr =
      checkFile.replaceAll('File:', '').replaceAll('\'', '').trim();
  cleanedStr =
      cleanedStr.substring(cleanedStr.lastIndexOf(".") + 1, cleanedStr.length);
  // var typeOfFile = lookupMimeType(check);
  return fileTypes.contains(cleanedStr) ? true : false;
}
