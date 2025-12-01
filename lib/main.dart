import 'package:advent/door_widger.dart';
import 'package:advent/door_content.dart';
import 'package:advent/solution_manager.dart';
import 'package:advent/util.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.light),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
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
    SolutionManager.loadSolutions(); // Load user solutions on app start

    // Listen to solution changes and rebuild
    SolutionManager.solutionsChangedNotifier.addListener(_onSolutionsChanged);
  }

  @override
  void dispose() {
    _userInputController.dispose();
    SolutionManager.solutionsChangedNotifier.removeListener(_onSolutionsChanged);
    super.dispose();
  }

  void _onSolutionsChanged() {
    if (mounted) {
      setState(() {
        // Trigger rebuild when solutions change
      });
    }
  }

  (User?, bool) _identifyUser(String input) {
    if (input.isEmpty) return (null, false);

    bool isDevMode = false;
    if (input.endsWith('*dev')) {
      isDevMode = true;
      input = input.substring(0, input.length - 4).trim();
    }

    User? foundUser;
    for (final user in User.values) {
      if (input == user.keyWord) {
        foundUser = user;
      }
    }
    return (foundUser, isDevMode);
  }

  void _onUserInputChanged() {
    (User?, bool) identifiedUser = _identifyUser(_userInputController.text);
    User? newUser = identifiedUser.$1;
    bool newIsDevMode = identifiedUser.$2;

    if (newUser != currentUser || newIsDevMode != Util.isDevMode) {
      setState(() {
        currentUser = newUser;
        Util.isDevMode = newIsDevMode;
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
      await prefs.setStringList(storageKey, openedDoors.map((e) => e.toString()).toList());
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

  void toggleDoor(int doorNumber) {
    bool isOpen = openedDoors.contains(doorNumber);
    setState(() {
      if (isOpen) {
        openedDoors.remove(doorNumber);
      } else {
        openedDoors.add(doorNumber);
      }
    });
    _saveOpenedDoors();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> userSolutions = SolutionManager.getAllUserSolutions();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 700,
                height: 1200,
                child: Center(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 26,
                      mainAxisSpacing: 26,
                      childAspectRatio: 1,
                    ),
                    itemCount: 24,
                    itemBuilder: (context, index) {
                      final doorNumber = shuffledDoors[index];
                      final doorContent = DoorContent.findContent(doorNumber, currentUser, userSolutions);
                      final isOpened = openedDoors.contains(doorNumber);
                      final isOpenable = Util.isDoorOpenable(
                          currentUser,
                          doorContent,
                          doorNumber,
                          Util.getCurrentDayOfDec2025(),
                        );

                      return DoorWidget(
                        key: ValueKey('door_$doorNumber'),
                        doorNumber: doorNumber,
                        user: currentUser,
                        doorContent: doorContent,
                        isOpenable: isOpenable,
                        isOpened: isOpened,
                        toogleDoorOpened: () => toggleDoor(doorNumber),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          // User identification input at the bottom
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _userInputController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Jelszó?',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                if (currentUser != null) ...[
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Text(
                          currentUser!.displayName,
                          style: TextStyle(color: Color.fromARGB(255, 151, 62, 62), fontWeight: FontWeight.bold),
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
