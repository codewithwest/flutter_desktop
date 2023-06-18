// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_knight_player/decorations/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/folders/folders.dart';
import 'screens/try.dart';
//import 'screens/player.dart';
import 'screens/all_music/allmusic.dart';
import 'screens/favorites/favorites.dart';
import 'screens/player.dart';
import 'screens/playlists/playlists.dart';
import 'screens/settings/settings.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final List<Widget> _screens = [
    AllMusic(),
    const Folders(),
    const Favorites(),
    const Playlist(),
    const Settings()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
          bottomNavigationBar: MediaQuery.of(context).size.width < 800
              ? BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  iconSize: 30,
                  selectedFontSize: 20,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: KnightColors().secondaryColor(),
                  // called when one tab is selected
                  onTap: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  // bottom tab items
                  items: [
                      tabNames(Icons.library_music, "Home"),
                      tabNames(Icons.folder_copy, "Folders"),
                      tabNames(Icons.favorite, "Favorites"),
                      tabNames(Icons.playlist_play, "Playlist"),
                      tabNames(Icons.settings, "Settings"),
                    ])
              : null,
          body: Row(
            children: [
              if (MediaQuery.of(context).size.width > 800)
                NavigationRail(
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  selectedIndex: _selectedIndex,
                  destinations: [
                    tabDestinations(Icons.library_music, "All Music"),
                    tabDestinations(Icons.folder_copy, "Folders"),
                    tabDestinations(Icons.favorite, "Favorites"),
                    tabDestinations(Icons.playlist_play, "Playlist"),
                    tabDestinations(Icons.settings, "Settings"),
                  ],

                  labelType: NavigationRailLabelType.all,
                  selectedLabelTextStyle: const TextStyle(
                    color: Colors.teal,
                  ),

                  unselectedLabelTextStyle: const TextStyle(),
                  // Called when one tab is selected
                  leading: const Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.music_note),
                      ),
                    ],
                  ),
                ),
              Expanded(child: _screens[_selectedIndex])
            ],
          ),
          //this is optional
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

tabNames(IconData iconName, label) {
  return BottomNavigationBarItem(
    icon: Icon(iconName),
    label: label,
  );
}

tabDestinations(IconData iconNamed, String label) {
  return NavigationRailDestination(
    icon: Icon(
      iconNamed,
    ),
    label: Text(label),
  );
}
