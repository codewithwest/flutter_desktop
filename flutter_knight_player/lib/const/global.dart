import 'dart:io';

class AppGlobalsConst {
  // Letters of the Alphabet
  static List letters = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  // Stores The DirectoryList
  var allDirectoryList = [];
  // Stores all Music Files
  var allFilesList = [];
  // List of All Music File Type
  List musicfileTypes = [
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
}

class AppGlobalFunctions extends AppGlobalsConst {
  // Converts string to lower case and return true if a substring is contained
  toStringtoLower(el, String subStrCheck) {
    return el.toString().toLowerCase().contains(subStrCheck);
  }

  // Checks the audio file formats that matches returns true if match
  isAudioFileFormat(String checkFile) {
    String cleanedStr =
        checkFile.replaceAll('File:', '').replaceAll('\'', '').trim();
    cleanedStr = cleanedStr.substring(
        cleanedStr.lastIndexOf(".") + 1, cleanedStr.length);
    // var typeOfFile = lookupMimeType(check);
    return musicfileTypes.contains(cleanedStr) ? true : false;
  }

// Gets all Files from a directory tree
  sortDirectoryFiles(directoryToCheck) async {
    // ignore: prefer_typing_uninitialized_variables
    var directoryList;
    if (directoryToCheck.existsSync()) {
      try {
        directoryList = await directoryToCheck.listSync().toList();
        for (var element in directoryList) {
          if (toStringtoLower(element, 'directory:')) {
            toStringtoLower(element, 'windows') ||
                    toStringtoLower(element, 'program files') ||
                    toStringtoLower(element, 'perflogs') ||
                    toStringtoLower(element, 'recovery') ||
                    toStringtoLower(element, 'backup') ||
                    toStringtoLower(element, 'drivers') ||
                    toStringtoLower(element, 'appdata') ||
                    toStringtoLower(element, 'programdata')
                ? print('not')
                : allDirectoryList.add(element);
          } else {
            isAudioFileFormat(element.toString())
                ? allFilesList.add(element)
                : false;
            // allFilesList = allFilesList;
          }
        }
        // dig deeper
        List listOfCurrentDir = [];
        listOfCurrentDir = allDirectoryList;
        allDirectoryList = [];
        if (listOfCurrentDir.isNotEmpty) {
          for (var folders in listOfCurrentDir) {
            await sortDirectoryFiles(folders);
          }
        }
      } catch (err) {
        false;
      }
    }
    return allFilesList;
    // print("All Files List {AppGlobalsConst} = ${allFilesList.length}");
    // print("All Files List {list} = ${allFilesList.length}");
  }

//Wild card start up function runs only on first
//Application startup after installation

  getAllMusicFilesFromAllDrives() async {
    for (var char in AppGlobalsConst.letters) {
      Directory newDir = Directory("${char.toUpperCase()}:");
      if (newDir.existsSync()) {
        await sortDirectoryFiles(newDir);
      }
    }
    return allFilesList;
  }
}
