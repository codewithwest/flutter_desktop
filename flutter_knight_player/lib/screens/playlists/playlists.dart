import 'package:flutter/material.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}


class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        scrollDirection: Axis.vertical,

        itemCount: 20, //playListList.length
        padding: const EdgeInsets.symmetric(horizontal: 25),
        //SliverGridDelegateWithFixedCrossAxisCount
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 800 ? 3 : 5,
            childAspectRatio: 1,
            crossAxisSpacing: 2),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/playlist1.jpg'),
                fit: BoxFit.cover,
              ),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 1,
                    color: Colors.blue,
                    blurStyle: BlurStyle.normal)
              ],
              border: Border.all(),
            ),
            child: Column(
              children: [
                playlistNumber(0),
                playlistName("PlayListName"),
                playlistDuration("playList Duration"),
                playlistTotal(22)
              ],
            ),
          );
          //smartDeviceName: mySmartDevices[index][0],
          //iconPath: mySmartDevices[index][1],
          //powerOn: mySmartDevices[index][2],
          //onChanged: (value) => powerSwitchChanged(value, index),
        },
      ),
    );
  }
}

playlistNumber(number) {
  return Row(children: [
    Container(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(1),
          boxShadow: const [
            BoxShadow(
              blurRadius: .1,
              color: Colors.blue,
            ),
          ],
          //border: Border.all(),
        ),
        child: Text(
          '$number',
          style: const TextStyle(fontSize: 24),
        )),
  ]);
}

playlistTotal(totNo) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    Container(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(1),
          boxShadow: const [
            BoxShadow(
              blurRadius: .1,
              color: Colors.green,
              blurStyle: BlurStyle.normal,
            ),
          ],
          //border: Border.all(),
        ),
        child: Text('$totNo')),
  ]);
}

playlistName(playListN) {
  return Expanded(
      flex: 6,
      child: Text(
        "$playListN",
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
      ));
}

playlistDuration(playListD) {
  return Expanded(
      flex: 2,
      child: Text(
        "$playListD",
        style: const TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ));
}
