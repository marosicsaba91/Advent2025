import 'package:advent/task.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class DoorContent {
  final Widget child;
  final String icon;
  final String? passKey;
  const DoorContent({required this.icon, required this.child, this.passKey});
}

class DoorContentManager {
  static DoorContent? getContent(int day, User? user) {

    final taskAndClue = dayUserToTaskClueTable(day, user);
    final String taskID = taskAndClue.$1;
    Task? task = TaskManager.getTask(taskID);
    if (task == null) return null;

    final int clueNumber = taskAndClue.$2;
    if (task.clues.length <= clueNumber-1 || clueNumber <= 0) return null;

    bool isLastClue = (clueNumber == task.clues.length);

    if (isLastClue) {
      String passKey = task.keyToSolve;
      return DoorContent(icon: task.icon, child: task.clues[clueNumber - 1], passKey: passKey);
    }

    return DoorContent(icon: task.icon, child: task.clues[clueNumber - 1]);
  }

  static (String, int) dayUserToTaskClueTable(int day, User? user) => switch ((day, user)) {
    (1, User.zsuzsiKicsim) => ("🌏", 1),
    (1, User.kataBalazs) => ("🔔", 1),
    (1, User.mariMatyi) => ("🔔", 2),
    (1, User.dorkaMate) => ("⭐", 1),

    (2, User.zsuzsiKicsim) => ("🔔", 3),
    (2, User.kataBalazs) => ("⭐", 2),
    (2, User.mariMatyi) => ("🌏", 2),
    (2, User.dorkaMate) => ("🍞", 1),

    (3, User.zsuzsiKicsim) => ("⭐", 3),
    (3, User.kataBalazs) => ("🌏", 3),
    (3, User.mariMatyi) => ("🔔", 4),
    (3, User.dorkaMate) => ("🔔", 5),

    (4, User.zsuzsiKicsim) => ("🔔", 6),
    (4, User.kataBalazs) => ("⭐", 4),
    (4, User.mariMatyi) => ("🍞", 2),
    (4, User.dorkaMate) => ("🌏", 4),

    (5, User.zsuzsiKicsim) => ("🌏", 5),
    (5, User.kataBalazs) => ("🌏", 6),       // 🔑
    (5, User.mariMatyi) => ("⭐", 5),
    (5, User.dorkaMate) => ("🔔", 7),

    (6, User.zsuzsiKicsim) => ("🍞", 3),
    (6, User.kataBalazs) => ("🔔", 8),
    (6, User.mariMatyi) => ("🔔", 9),        // 🔑
    (6, User.dorkaMate) => ("⭐", 6),

    (7, User.zsuzsiKicsim) => ("⭐", 7),
    (7, User.kataBalazs) => ("⭐", 8),
    (7, User.mariMatyi) => ("🍞", 4),
    (7, User.dorkaMate) => ("🎅", 1),

    (8, User.zsuzsiKicsim) => ("🎅", 2),
    (8, User.kataBalazs) => ("🍞", 5),
    (8, User.mariMatyi) => ("🎅", 3),
    (8, User.dorkaMate) => ("🍞", 6),

    _ => ("🌏", 0),
  };
}
