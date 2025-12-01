import 'dart:math';

import 'package:advent/door_content.dart';
import 'package:advent/main.dart';

class Util {
  static bool isDevMode = false;

  static int getCurrentDayOfDec2025() {
    final now = DateTime.now();
    int result = now.day;

    if (now.year != 2025 || now.month != 12) {
      final timeSpan = now.difference(DateTime(2025, 12, 1));
      result = timeSpan.inDays;
    }

    return isDevMode ? max(24, result) : result;
  }

  static void print(String imagePathLocal) {}

  static bool isDoorOpenable(User? user, DoorContent? content, int doorNumber, int currentDay) =>
      (user == null) ||
      (currentDay < doorNumber) ||
      ((content != null) && ((content.unlockedTask.isEmpty) || (content.lockedTasks > 0)));

  static String? anyReasonNotToOpen(User? user, DoorContent? content, int doorNumber, int currentDay) {
    if (user == null) {
      return 'Nincs jelszó, nincs csoki!\n🔑 👉 🍫';
    } else if (currentDay < doorNumber) {
      return _getWaitText(doorNumber - currentDay);
    } else if (content == null) {
      return null;
    } else if (content.unlockedTask.isEmpty && content.lockedTasks > 0) {
      return 'Először old meg a feladatokat!';
    } else if (content.lockedTasks > 0) {
      return 'Még nem oldottál meg ${content.lockedTasks} feladatot!';
    }
    return null;
  }

  static String _getWaitText(int days) {
    int lastDigit = days % 10;
    String numberSuffix = switch (lastDigit) {
      1 => '-et',
      2 => '-t',
      3 => '-at',
      4 => '-et',
      5 => '-öt',
      6 => '-ot',
      7 => '-et',
      8 => '-at',
      9 => '-et',
      _ => '-t',
    };
    // As many sleepy faces as days
    String sleepyFaces = '😴' * days;

    return 'Még $days$numberSuffix kell aludni!\n$sleepyFaces';
  }
}
