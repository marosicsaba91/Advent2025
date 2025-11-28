import 'package:advent/advent_door.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

// Simple deterministic random number generator
class _SeededRandom {
  int _seed;

  _SeededRandom(this._seed);

  int nextInt(int max) {
    _seed = ((_seed * 1103515245 + 12345) & 0x7fffffff);
    return _seed % max;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advent Calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AdventCalendarPage(),
    );
  }
}

class AdventCalendarPage extends StatefulWidget {
  const AdventCalendarPage({super.key});

  @override
  State<AdventCalendarPage> createState() => _AdventCalendarPageState();
}

class _AdventCalendarPageState extends State<AdventCalendarPage> {
  // Map of door numbers to their content
  final Map<int, String> doorContents = {
    1: "🎄 Welcome to the Advent Calendar! Let the holiday magic begin!",
    2: "⭐ May your days be merry and bright!",
    3: "🎁 Three wise men traveled from afar...",
    4: "❄️ Let it snow, let it snow, let it snow!",
    5: "🕯️ Light a candle and make a wish.",
    6: "🎅 Santa is checking his list twice!",
    7: "🔔 Jingle bells, jingle all the way!",
    8: "🎵 Eight days until halfway through December!",
    9: "⛄ Do you want to build a snowman?",
    10: "🌟 Ten little elves working in the workshop.",
    11: "🦌 Rudolph with your nose so bright!",
    12: "🎀 Twelve drummers drumming...",
    13: "🍪 Time for milk and cookies!",
    14: "🧦 Don't forget to hang your stockings!",
    15: "🎶 Silent night, holy night.",
    16: "🏠 Home is where the heart is this holiday season.",
    17: "💝 Spread love and kindness everywhere you go.",
    18: "✨ Magic is in the air!",
    19: "🎊 The countdown is getting exciting!",
    20: "🌲 Only a few more days until Christmas!",
    21: "🎺 Three days to go! Can you feel the excitement?",
    22: "🎪 Two more sleeps until Christmas!",
    23: "🌙 Christmas Eve is tomorrow!",
    24: "🎉 Merry Christmas Eve! Santa comes tonight!",
  };

  final Map<int, String> doorIcon = {
    1: "🕯️",
    2: "🎉",
    3: "🧦",
    
    4: "❄️",
    5: "⭐",
    6: "🎅",
    7: "🔔",
    8: "🎵",
    9: "⛄",
    10: "🌟",
    11: "🦌",
    12: "🎀",
    13: "🍪",
    14: "🎁",
    15: "🎶",
    16: "🏠",
    17: "💝",
    18: "🌲",
    19: "🎊",
    20: "✨",
    21: "🎺",
    22: "🎪",
    23: "🌙",
    24: "🎄",
  };

  Set<int> openedDoors = {};

  // Deterministic shuffle - always produces the same order
  late final List<int> shuffledDoors = _generateShuffledDoors();

  @override
  void initState() {
    super.initState();
    _loadOpenedDoors();
  }

  Future<void> _loadOpenedDoors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final openedDoorsList = prefs.getStringList('opened_doors') ?? [];
      if (mounted) {
        setState(() {
          openedDoors = openedDoorsList.map((e) => int.parse(e)).toSet();
        });
      }
    } catch (e) {
      // If SharedPreferences fails, just continue with empty set
      debugPrint('Failed to load opened doors: $e');
    }
  }

  Future<void> _saveOpenedDoors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'opened_doors',
        openedDoors.map((e) => e.toString()).toList(),
      );
    } catch (e) {
      // If SharedPreferences fails, just continue without saving
      debugPrint('Failed to save opened doors: $e');
    }
  }

  List<int> _generateShuffledDoors() {
    final doors = List.generate(24, (index) => index + 1);
    // Simple deterministic shuffle using a fixed seed algorithm
    final random = _SeededRandom(2025); // Use year as seed
    for (int i = doors.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      int temp = doors[i];
      doors[i] = doors[j];
      doors[j] = temp;
    }
    return doors;
  }

  // Get current December day (you can modify this for testing)
  int getCurrentDay() {
    final now = DateTime.now();
    if (now.year > 2025) {
      return 24;
    }
    if (now.year < 2025 || now.month < 11) {
      return 0;
    }
    return now.day - 10;
  }

  bool canOpenDoor(int doorNumber) {
    return doorNumber <= getCurrentDay();
  }

  void openDoor(int doorNumber) {
    if (canOpenDoor(doorNumber)) {
      setState(() {
        openedDoors.add(doorNumber);
      });
      _saveOpenedDoors();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Door $doorNumber'),
          content: Text(
            doorContents[doorNumber] ?? "Holiday cheer!",
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 34,
                    mainAxisSpacing: 34,
                    childAspectRatio: 1,
                  ),
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    final doorNumber = shuffledDoors[index];
                    final isOpenable = canOpenDoor(doorNumber);
                    final isOpened = openedDoors.contains(doorNumber);

                    return AdventDoor(
                      doorNumber: doorNumber,
                      doorIcon: doorIcon[doorNumber] ?? '',
                      isOpenable: isOpenable,
                      isOpened: isOpened,
                      onTap: () => openDoor(doorNumber),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
