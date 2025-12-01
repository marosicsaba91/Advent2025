import 'package:advent/advent_2025_task_definitions.dart';
import 'package:flutter/material.dart';

class Task {
  String icon;
  List<Widget> clues;
  List<String> correctSolutions;

  Task({required this.icon, required this.clues, required this.correctSolutions});
  bool get hasAnySolution => correctSolutions.isNotEmpty;


  static List<String> getAllTasks(bool Function(Task task) selector) {
    List<String> result = [];
    for (var taskId in TaskDefinitions.allTaskIDs) {
      Task? task = TaskDefinitions.getTask(taskId);
      if (task != null && selector(task)) {
        result.add(taskId);
      }
    }
    return result;
  }
}
