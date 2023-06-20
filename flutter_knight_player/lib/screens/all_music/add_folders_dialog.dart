// import 'package:flutter/material.dart';

// class DriveLoadDialog extends StatefulWidget {
//   const DriveLoadDialog({super.key});

//   @override
//   State<DriveLoadDialog> createState() => _DriveLoadDialogState();
// }

// class _DriveLoadDialogState extends State<DriveLoadDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _loadDrivesDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('AlertDialog Title'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('This is a demo alert dialog.'),
//                 Text('Would you like to approve of this message?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Done'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Future build(BuildContext context) {
//     return _loadDrivesDialog();
//   }
// }

import 'package:flutter/material.dart';
import '../../const/colors.dart';
import '../../const/global.dart';
import '../../decorations/decoration.dart';

listOfAvailableDirectories(availableDrives, someFun) {
  return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: availableDrives.length,
      itemBuilder: (context, index) {
        return Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.all(2),
                child: ElevatedButton(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  onPressed: () async {
                    var len = availableDrives[index].toString();
                    print(len.substring(len.length - 3, len.length - 2));
                    someFun(len.substring(len.length - 3, len.length - 2));
                  },
                  style: AllMusicDecorations().listButtonDecoration(),
                  child: ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => AppGlobalFunctions()
                          .sortDirectoryFiles(availableDrives[index]),
                    ),
                    visualDensity: VisualDensity.comfortable,
                    enableFeedback: true,
                    dense: true,
                    minLeadingWidth: 2,
                    iconColor: Colors.green,
                    leading: const Icon(Icons.storage),
                    title: Text(availableDrives[index]
                        .toString()
                        .replaceAll('Directory', 'Drive')
                        .replaceAll("'", '')),
                  ),
                )));
      });
}

Future<void> loadDrivesDialog(context, listOfAllDirectories, someFunc) async {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            padding: const EdgeInsets.all(20),
            decoration: AllMusicDecorations().folderDialog(),
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'List Of Available Drives',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: listOfAvailableDirectories(
                      listOfAllDirectories, someFunc),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(5),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.green),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        KnightColors().secondaryColor()),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white),
                  ),
                  // color: const Color(0xFF1BC0C5),
                )
              ],
            ),
          ),
        );
      });
}
