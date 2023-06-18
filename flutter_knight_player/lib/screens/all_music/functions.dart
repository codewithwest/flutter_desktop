

var allDirectoryList = [];
var allFilesList = [];

sortDirectoryFiles(directoryToCheck) async {
  // ignore: prefer_typing_uninitialized_variables
  var directoryList;

  if (directoryToCheck.existsSync()) {
    try {
      directoryList = directoryToCheck.listSync().toList();
      for (var element in directoryList) {
        if (element.toString().contains('Directory:')) {
          allDirectoryList.add(element);
        } else {
          isAudioFileFormat(element.toString())
              ? allFilesList.add(element)
              // [...{...ids}]
              : false;

          allFilesList = allFilesList.toSet().toList();
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
toStringtoLower(el, String subStrCheck) {
  return el.toString().toLowerCase().contains(subStrCheck);
}
