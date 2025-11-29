import 'package:advent/advent_door.dart';
import 'package:advent/door_content.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum User { dorkaMate, mariMatyi, kataBalazs, zsuzsiKicsim }

extension UserExtension on User {
  String get displayName => switch (this) {
    User.dorkaMate => 'Szia, Dorka és Máté!',
    User.mariMatyi => 'Szia, Mariann és Matyi!',
    User.kataBalazs => 'Szia, Kata és Balázs!',
    User.zsuzsiKicsim => 'Szia, kicsim! ❤️',
  };

  String get keyWord => switch (this) {
    User.dorkaMate => 'matador',
    User.mariMatyi => 'm&m\'s',
    User.kataBalazs => 'kabala',
    User.zsuzsiKicsim => 'okézsoké',
  };
}

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
  Set<int> openedDoors = {};

  // User management
  User? currentUser;
  final TextEditingController _userInputController = TextEditingController();

  // Deterministic shuffle - always produces the same order
  late final List<int> shuffledDoors = _generateShuffledDoors();

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _userInputController.addListener(_onUserInputChanged);
  }

  @override
  void dispose() {
    _userInputController.dispose();
    super.dispose();
  }

  User? _identifyUser(String input) {
    if (input.isEmpty) return null;

    User? foundUser;
    for (final user in User.values) {
      if (input == user.keyWord) {
        foundUser = user;
      }
    }
    return foundUser;
  }

  void _onUserInputChanged() {
    final identifiedUser = _identifyUser(_userInputController.text);
    if (identifiedUser != currentUser) {
      setState(() {
        currentUser = identifiedUser;
        openedDoors = {};
      });
      _saveCurrentUser();
      _loadOpenedDoors();
    }
  }

  Future<void> _loadCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedUserIndex = prefs.getInt('current_user_index');
      if (savedUserIndex != null && savedUserIndex < User.values.length) {
        final savedUser = User.values[savedUserIndex];
        if (mounted) {
          setState(() {
            currentUser = savedUser;
            _userInputController.text = savedUser.keyWord;
          });
          _loadOpenedDoors();
        }
      }
    } catch (e) {
      debugPrint('Failed to load current user: $e');
    }
  }

  Future<void> _saveCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (currentUser != null) {
        await prefs.setInt('current_user_index', currentUser!.index);
      } else {
        await prefs.remove('current_user_index');
      }
    } catch (e) {
      debugPrint('Failed to save current user: $e');
    }
  }

  String _getStorageKey(String key) => '${currentUser!.name}_$key';

  Future<void> _loadOpenedDoors() async {
    try {
      if (currentUser == null) return;

      final prefs = await SharedPreferences.getInstance();
      final storageKey = _getStorageKey('opened_doors');
      final openedDoorsList = prefs.getStringList(storageKey) ?? [];
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
      if (currentUser == null) return;
      final prefs = await SharedPreferences.getInstance();
      final storageKey = _getStorageKey('opened_doors');
      await prefs.setStringList(
        storageKey,
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
    // No user = no doors can be opened
    if (currentUser == null) {
      return false;
    }
    return doorNumber <= getCurrentDay();
  }

  void toggleDoor(int doorNumber) {
    if (canOpenDoor(doorNumber)) {
      setState(() {
        if (openedDoors.contains(doorNumber)) {
          openedDoors.remove(doorNumber);
        } else {
          openedDoors.add(doorNumber);
        }
      });
      _saveOpenedDoors();
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
                      key: ValueKey('door_$doorNumber'),
                      doorNumber: doorNumber,
                      user: currentUser,
                      doorContent:
                          DoorContentManager.content[(doorNumber, currentUser)],
                      isOpenable: isOpenable,
                      isOpened: isOpened,
                      onTap: () => toggleDoor(doorNumber),
                    );
                  },
                ),
              ),
            ),
          ),
          // User identification input at the bottom
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _userInputController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Jelszó?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                if (currentUser != null) ...[
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          currentUser!.displayName,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
