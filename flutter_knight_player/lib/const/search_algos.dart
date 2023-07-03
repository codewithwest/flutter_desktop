import 'dart:io';
import 'const_vars.dart';

class AppGlobalFunctions extends AppGlobalsConst {
  // Converts string to lower case and return true if a substring is contained
  toStringtoLower(el, String subStrCheck) {
    return el.toString().toLowerCase().contains(subStrCheck);
  }

  checkifFolderIsEmpty(directoyPath) async {
    var newListedDir = await directoyPath.list().isEmpty;
    // directoyPath.listSync().toList();
    return newListedDir;
  }

  // Checks if a folder/ file name contains variations
  checkifContains(elementToCheck, List listToIterate) {
    bool p = false;
    for (var i = 0; i < listToIterate.length; i++) {
      var downEl = elementToCheck.toString().toLowerCase();
      var substr =
          downEl.substring(downEl.lastIndexOf('\\') + 1, downEl.length);
      if (downEl.contains(listToIterate[i]) ||
          substr.startsWith('.') ||
          (downEl.contains('file:') && !isAudioFileFormat(substr))) {
        p = true;
      }
    }
    return p;
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
  sortDirectoryFiles(directoyPath) async {
    // ignore: prefer_typing_uninitialized_variables
    var directoryList;
    if (directoyPath.existsSync()) {
      try {
        directoryList = await directoyPath.listSync().toList();
        for (var element in directoryList) {
          if (toStringtoLower(element, 'directory:')) {
            checkifContains(element, exceptionFolders)
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

  getAllDrivesOnSystem() {
    for (var char in AppGlobalsConst.letters) {
      Directory newDir = Directory("${char.toUpperCase()}:");
      if (newDir.existsSync()) {
        allDrivesList.contains(newDir) ? true : allDrivesList.add(newDir);
      }
    }
    return allDrivesList;
  }
}
