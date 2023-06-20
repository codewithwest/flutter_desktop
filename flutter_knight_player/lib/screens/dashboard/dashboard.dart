import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:flutter_knight_player/screens/dashboard/dashboard_helpers.dart';

class DashBoard extends StatefulWidget {
  // const DashBoard({Key? key}) : super(key: key);

  final Function notifyParentTheme;

  // ignore: prefer_typing_uninitialized_variables

  const DashBoard({
    // super.key,
    Key? key,
    required this.notifyParentTheme,
  });

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  // var screens = DashBoardHelpers().screens(widget.notifyParentTheme);
  int _selectedIndex = 0;
  late List screens = DashBoardHelpers().screens(widget.notifyParentTheme);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return true;
        }
        setState(() {
          _selectedIndex = 0;
        });
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: width < 800
            ? DashBoardHelpers().bottomNavBarHandler(setState, _selectedIndex)
            : null,
        body: Column(children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.fromLTRB(6, 3, 6, 2),
              decoration: AllMusicDecorations().topTabDecoration(),
              padding: const EdgeInsets.fromLTRB(5, 5, 2, 2),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 3,
                    child: ListTile(
                      leading: Icon(Icons.music_note),
                      // title: Text("${allMusicFilesList.length} Songs"),
                      // trailing:
                      //     Text('Total Time: ${allMusicFilesList.length * 60}'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navigation bar container and handler
          Expanded(
            flex: 8,
            child: Row(
              children: [
                if (width > 800)
                  DashBoardHelpers()
                      .navigationRailHelper(setState, _selectedIndex),
                Expanded(child: screens[_selectedIndex])
              ],
            ),
          ),
          //this is optional)
        ]),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
