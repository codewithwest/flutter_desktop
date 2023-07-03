import 'package:flutter/material.dart';
import 'package:flutter_knight_player/screens/all_music/allmusic.dart';
import 'package:flutter_knight_player/screens/favorites/favorites.dart';
import 'package:flutter_knight_player/screens/folders/folders.dart';
import 'package:flutter_knight_player/screens/playlists/playlists.dart';
import 'package:flutter_knight_player/screens/settings/settings.dart';
import '../../const/colors.dart';

class DashBoardHelpers {
  screens(
    List allMusicList,
    List allFavorites,
    bool listView,
    String urlToPlay,
    notifyParentPlaySong,
    notifyFavorites,
    notifyTheme,
  ) {
    return <Widget>[
      Folders(
        notifyParentPlayer: notifyParentPlaySong,
      ),
      AllMusic(
        allMusicList: allMusicList,
        allFavoriteMusicList: allFavorites,
        listView: listView,
        urlToPlay: urlToPlay,
        notifyParentPlayer: notifyParentPlaySong,
        notifyParentfavourites: notifyFavorites,
      ),
      const Favorites(),
      const Playlist(),
      Settings(
        notifyParentTheme: notifyTheme,
      ),
    ];
  }

  tabDestinationHandler() {
    return <NavigationRailDestination>[
      tabDestinations(Icons.library_music, "All Music"),
      tabDestinations(Icons.folder_copy, "Folders"),
      tabDestinations(Icons.favorite, "Favorites"),
      tabDestinations(Icons.playlist_play, "Playlist"),
      tabDestinations(Icons.settings, "Settings"),
    ];
  }

  tabNames(IconData iconName, label) {
    return BottomNavigationBarItem(
      icon: Icon(iconName),
      label: label,
    );
  }

  tabNamesHandler() {
    return <BottomNavigationBarItem>[
      tabNames(Icons.library_music, "Home"),
      tabNames(Icons.folder_copy, "Folders"),
      tabNames(Icons.favorite, "Favorites"),
      tabNames(Icons.playlist_play, "Playlist"),
      tabNames(Icons.settings, "Settings"),
    ];
  }

  tabDestinations(IconData iconNamed, String label) {
    return NavigationRailDestination(
      icon: Icon(
        iconNamed,
      ),
      label: Text(label),
    );
  }

  bottomNavBarHandler(stateHandler, _selectedIndex) {
    return BottomNavigationBar(
        currentIndex: _selectedIndex,
        iconSize: 30,
        selectedFontSize: 20,
        unselectedItemColor: Colors.grey,
        selectedItemColor: KnightColors().secondaryColor(),
        // called when one tab is selected
        onTap: (int index) => {stateHandler(_selectedIndex, index)},

        // bottom tab items
        items: tabNamesHandler());
  }

  navigationRailHelper(stateHandler, selectedIndex) {
    return NavigationRail(
      onDestinationSelected: (int index) =>
          {stateHandler(selectedIndex, index)},
      selectedIndex: selectedIndex,
      destinations: tabDestinationHandler(),

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
    );
  }
}
