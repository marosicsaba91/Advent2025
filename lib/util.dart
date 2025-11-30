import 'dart:math';

class Util
{ 
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
}
