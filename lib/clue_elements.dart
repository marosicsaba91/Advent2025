import 'dart:math';

import 'package:advent/util.dart' show Util;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class ClueRow extends StatelessWidget {
  const ClueRow(this.items, {super.key});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) => Row(
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

class ClueTimeLock extends StatelessWidget {
  const ClueTimeLock(this.imagePath, this.cuncoverableText, this.hour, this.minute, {super.key, this.color});

  final String imagePath;
  final String cuncoverableText;
  final int hour;
  final int minute;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    int totalMinutesNow = now.hour * 60 + now.minute;
    int totalMinutesLock = hour * 60 + minute;
    int difference = (totalMinutesLock - totalMinutesNow).abs();
    difference = min(difference, 1440 - difference);

    String imagePathLocal = "assets/$imagePath";
    Widget image = SizedBox(width: 400, height: 400, child: Image.asset(imagePathLocal));
    if (difference <= 8) {
      return SizedBox(
        width: 400,
        height: 400,
        child: Stack(
          children: [
            image,
            Center(
              child: Text(
                cuncoverableText,
                textAlign: TextAlign.center,
                style: GoogleFonts.cinzel(
                  fontSize: 300,
                  fontWeight: FontWeight.bold,
                  color: color?.withAlpha(150) ?? const Color.fromARGB(150, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ClueColumn(  
      [
        image,
        ClueText("Rossz időzítés!"),
      ],
    );
  }
}
