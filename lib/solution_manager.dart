import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SolutionManager {
  static const String key = 'solution_';
  static Map<String, String> _userSolutions = {};
  
  // Notifier to trigger rebuilds when solutions change
  static final ValueNotifier<int> solutionsChangedNotifier = ValueNotifier<int>(0);

  // Load solutions from storage
  static Future<void> loadSolutions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys().where((k) => k.startsWith(key)).toList();
      _userSolutions.clear();
      for (final storageKey in allKeys) {
        final taskId = storageKey.substring(key.length);
        final solution = prefs.getString(storageKey) ?? '';
        _userSolutions[taskId] = solution;
      }
    } catch (e) {
      debugPrint('Failed to load user solutions: $e');
      _userSolutions = {};
    }
  }

  // Save a single solution to storage
  static Future<void> _saveSolution(String taskId, String solution) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('$key$taskId', solution);
    } catch (e) {
      debugPrint('Failed to save user solution: $e');
    }
  }

  // Get solution for a specific task by taskId (e.g., "🌏", "⭐", "🔔")
  static String getUserSolution(String taskId) {
    return _userSolutions[taskId] ?? '';
  }

  // Set solution for a specific task by taskId (automatically saves)
  static Future<void> setUserSolution(String taskId, String solution) async {
    _userSolutions[taskId] = solution;
    await _saveSolution(taskId, solution);
    // Notify listeners that solutions have changed
    solutionsChangedNotifier.value++;
  }

  // Get all solutions
  static Map<String, String> getAllUserSolutions() => Map.from(_userSolutions);
}
