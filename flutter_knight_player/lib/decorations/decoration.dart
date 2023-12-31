import 'package:flutter/material.dart';
import 'package:flutter_knight_player/const/colors.dart';

class AllMusicDecorations extends KnightColors {
  topTabDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(147, 2, 244, 0.409),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ]);
  }

  folderDialog() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: KnightColors().secondaryColor(),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          )
        ]);
  }

  buttonDecoration() {
    return ButtonStyle(
      elevation: MaterialStateProperty.all<double>(5),
      minimumSize: MaterialStateProperty.all<Size>(const Size.fromWidth(80)),
      shadowColor: MaterialStateProperty.all<Color>(Colors.green),
      backgroundColor:
          MaterialStateProperty.all<Color>(KnightColors().secondaryColor()),
    );
  }

  listButtonDecoration() {
    return ButtonStyle(
      shadowColor: MaterialStateProperty.all<Color>(Colors.green),
      backgroundColor:
          MaterialStateProperty.all<Color>(KnightColors().secondaryColor()),
    );
  }

  songCardDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(32, 77, 76, 78),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ]);
  }

  imageContainer() {
    return BoxDecoration(
      color: const Color.fromRGBO(22, 33, 44, .7),
      borderRadius: BorderRadius.circular(5),
      image: const DecorationImage(
        image: AssetImage('assets/images/demo.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  textContainer() {
    return BoxDecoration(
      color: const Color.fromRGBO(22, 33, 44, .12),
      borderRadius: BorderRadius.circular(5),
    );
  }

  cleanMusicListText(childToElement) {
    var cleanedStr = childToElement.toString().replaceAll('\'', "");
    cleanedStr = cleanedStr.substring(
        cleanedStr.lastIndexOf("\\") + 1, cleanedStr.length);
    return cleanedStr;
  }

  childText(childToElement, context) {
    return Text(
      cleanMusicListText(childToElement),
      textAlign: TextAlign.center,
      softWrap: true,
      style: TextStyle(
        fontStyle: FontStyle.italic,
        decorationThickness: 20,
        shadows: const [
          Shadow(
            offset: Offset(6, 3),
            color: Colors.black12,
          )
        ],
        fontSize: MediaQuery.of(context).size.width < 800
            ? MediaQuery.of(context).size.width < 550
                ? MediaQuery.of(context).size.width < 350
                    ? 8
                    : 10
                : 10
            : 13,
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 220);
    path.quadraticBezierTo(size.width / 4, 160 /*180*/, size.width / 2, 175);
    path.quadraticBezierTo(3 / 4 * size.width, 190, size.width, 130);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
