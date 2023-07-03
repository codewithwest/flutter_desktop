import 'package:flutter/material.dart';
import 'package:flutter_knight_player/const/colors.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:flutter_knight_player/main.dart';

class Settings extends StatefulWidget {
  final Function notifyParentTheme;
  const Settings({
    Key? key,
    required this.notifyParentTheme,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          ElevatedButton(
              style: AllMusicDecorations().listButtonDecoration(),
              onPressed: () => widget.notifyParentTheme(),
              child: ListTile(
                hoverColor: KnightColors().secondaryColor(),
                title: Text(themeModeDark ? 'Dark theme' : 'Light Theme'),
                trailing:
                    Icon(!themeModeDark ? Icons.dark_mode : Icons.light_mode),
              )),
        ],
      ),
    );
  }
}
