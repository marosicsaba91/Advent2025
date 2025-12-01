import 'package:advent/advent_2025_door_map.dart';
import 'package:advent/advent_2025_task_definitions.dart';
import 'package:advent/clue_elements.dart';
import 'package:advent/solution_manager.dart';
import 'package:advent/task.dart';
import 'package:advent/clue_solution.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class DoorContent {
  final Widget child;
  final String taskID; // icon
  final String? userSolution;
  final List<String> correctSolutions;
  final int locks;
  final int openLocks;
  final bool solvable;

  DoorContent({
    required this.taskID,
    required this.child,
    required this.locks,
    required this.openLocks,
    required this.userSolution,
    required this.correctSolutions,
    required this.solvable,
  });

  String? get bottomText {
    if (locks > 0) {
      return "🔒" * (locks - openLocks) + "🔓" * openLocks;
    }
    return null;
  }

  Widget getFullContent(BuildContext context) {
    if (!solvable) {
      return child;
    }

    return ClueColumn([
      child,
      ClueSolution(
        taskID: taskID,
        userInput: SolutionManager.getUserSolution(taskID),
        correctSolutions: correctSolutions,
      ),
    ]);
  }

  static DoorContent? findContent(int day, User? user, Map<String, String> userSolutions) {
    if (user == null) return null;
    final taskAndClue = DoorMap.dayUserToTaskClueTable(day, user);
    final String taskID = taskAndClue.$1;
    Task? task = TaskDefinitions.getTask(taskID);
    if (task == null) return null;

    final int clueNumber = taskAndClue.$2;
    if (task.clues.length <= clueNumber - 1 || clueNumber <= 0) return null;

    bool isLastClue = (clueNumber == task.clues.length);
    bool isLastTask = (day == 24);

    bool solvable = (isLastClue && !isLastTask && task.correctSolutions.isNotEmpty);

    int openLocks = 0, locks = 0;
    if (isLastTask) {
      List<String> lockerTask = DoorMap.getLockerTask(user);

      for (var lockerTaskID in lockerTask) {
        locks += 1;
        Task lockerTask = TaskDefinitions.getTask(lockerTaskID)!;
        if (userSolutions.containsKey(lockerTaskID) &&
            lockerTask.correctSolutions.any((n) => n.toLowerCase() == userSolutions[lockerTaskID]?.toLowerCase())) {
          openLocks += 1;
        }
      }
    }

    return DoorContent(
      taskID: task.icon,
      child: task.clues[clueNumber - 1],
      locks: locks,
      openLocks: openLocks,
      userSolution: userSolutions[taskID],
      correctSolutions: task.correctSolutions,
      solvable: solvable,
    );
  }
}
