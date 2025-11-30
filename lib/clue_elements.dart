import 'package:advent/util.dart' show Util;
import 'package:flutter/material.dart';

class ClueColumn extends StatelessWidget {
  const ClueColumn(this.items, {super.key});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    spacing: 10,
    children: items,
  );
}

class ClueText extends StatelessWidget {
  const ClueText(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) => Text(message, style: const TextStyle(fontSize: 18));
}

class ClueImage extends StatelessWidget {
  const ClueImage(this.imagePath, {super.key, this.width, this.height, this.print = false});

  final String imagePath;
  final double? width;
  final double? height;
  final bool print;

  @override
  Widget build(BuildContext context) {
    String imagePathLocal = "assets/$imagePath";
    Widget image = SizedBox(width: width, height: height, child: Image.asset(imagePathLocal));
    if (print) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          image,
          ElevatedButton(
            onPressed: () => Util.print(imagePathLocal),
            style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            child: ClueText("Nyomtatás"),
          ),
        ],
      );
    }
    return image;
  }
}

class ClueBell extends StatelessWidget {
  const ClueBell(this.imagePath,this.soundPath, {super.key});

  final String imagePath;
  final String soundPath; 

  @override
  Widget build(BuildContext context) {
    String imagePathLocal = "assets/$imagePath";
    //String soundPathLocal = "assets/$soundPath";
    Widget image = SizedBox(width: 400, height: 400, child: Image.asset(imagePathLocal));
    // TODO
    return image;
  }
}

class ClueTimeLock extends StatelessWidget {
  const ClueTimeLock(this.imagePath, this.cuncoverableText, this.hour, this.minute, {super.key});

  final String imagePath;
  final String cuncoverableText; 
  final int hour;
  final int minute;

  @override
  Widget build(BuildContext context) {
    String imagePathLocal = "assets/$imagePath";
    Widget image = SizedBox(width: 400, height: 400, child: Image.asset(imagePathLocal));
    // TODO
    return image;
  }
}