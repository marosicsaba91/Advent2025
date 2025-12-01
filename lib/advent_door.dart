import 'package:advent/door_content.dart';
import 'package:advent/main.dart';
import 'package:advent/util.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DoorWidget extends StatefulWidget {
  final int doorNumber;
  final User? user;
  final DoorContent? doorContent;
  final bool isOpenable;
  final bool isOpened;
  final VoidCallback onTap;

  const DoorWidget({
    super.key,
    required this.doorNumber,
    required this.user,
    required this.doorContent,
    required this.isOpenable,
    required this.isOpened,
    required this.onTap,
  });

  @override
  State<DoorWidget> createState() => _DoorWidgetState();
}

class _DoorWidgetState extends State<DoorWidget> with TickerProviderStateMixin {
  late AnimationController _openCloseAnimationController;
  late Animation<double> _openCloseAnimation;
  late AnimationController _shakeAnimationController;
  late Animation<double> _shakeAnimation;
  late Animation<double> _highlightAnimation;

  Color get doorColor => (widget.isOpenable) ? Color.fromARGB(255, 235, 61, 61) : Color.fromARGB(255, 235, 61, 61);
  Color get doorBorderColor =>
      (widget.isOpenable) ? const Color.fromARGB(255, 131, 27, 27) : const Color.fromARGB(255, 131, 27, 27);
  Color get doorOrnamentColor =>
      (widget.isOpenable) ? const Color.fromARGB(255, 211, 51, 51) : const Color.fromARGB(255, 211, 51, 51);
  Color get doorTextColor =>
      (widget.isOpenable) ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 255, 255, 255);
  Color get doorKnobColor =>
      (widget.isOpenable) ? const Color.fromARGB(255, 255, 195, 91) : const Color.fromARGB(255, 238, 151, 0);

  Color get backgroundDarkColor => const Color.fromARGB(255, 51, 40, 39);
  Color get backgroundLightColor => const Color.fromARGB(255, 97, 74, 68);
  Color get backgroundButtonColor => const Color.fromARGB(255, 77, 60, 56);

  static const double doorBorderWidth = 2;
  static const double doorCorner = 14;
  static const double innerContentMargin = 10;
  static const double innerContentCorner = 6;

  static const double oranmentWidth = 4;

  static const double oranment1Margin = 6;
  static const double oranment1Corner = 10;

  static const double oranment2Margin = 4;
  static const double oranment2Corner = 6;

  static const double openDegree = 96;

  double oppennedDegree() => _openCloseAnimation.value * openDegree;

  @override
  void initState() {
    super.initState();

    _openCloseAnimationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _shakeAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _openCloseAnimation = Tween<double>(
      begin: 0,
      end: 1, // degrees to open
    ).animate(CurvedAnimation(parent: _openCloseAnimationController, curve: Curves.easeInOut));

    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _shakeAnimationController, curve: Curves.easeInOut));
    _highlightAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _shakeAnimationController, curve: Curves.easeOut));

    if (widget.isOpened) {
      _openCloseAnimationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(DoorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpened != oldWidget.isOpened) {
      if (widget.isOpened) {
        _openCloseAnimationController.forward();
      } else {
        _openCloseAnimationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _openCloseAnimationController.dispose();
    _shakeAnimationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onTap();

    if (!widget.isOpenable && !widget.isOpened) {
      {
        _shakeAnimationController.forward(from: 0);

        User? user = widget.user;
        int currentDay = Util.getCurrentDayOfDec2025();

        if (user == null || currentDay < widget.doorNumber) {
          _showDoorDialog(user, widget.doorNumber, widget.doorContent, context);
        }
      }
    }
  }

  List<String> noContentIcons = ['😕', '🤔', '🫤', '😐', '😑', '🤐', '😔', '😞', '😞', '☹️', '😒', '🙄', '😬', '😳'];

  static void _showDoorDialog(User? user, int doorNumber, DoorContent? content, BuildContext context) {
    int currentDay = Util.getCurrentDayOfDec2025();

    String? errorText = user == null
        ? 'Nincs jelszó, nincs csoki!\n🔑 👉 🍫'
        : currentDay < doorNumber
        ? _getWaitText(doorNumber - currentDay)
        : content == null
        ? 'Hmmm... 🤔 Valami nincs rendben!\nEgy nyom itt hiányzik.\nErről szólj Csaninak!'
        : null;

    Widget? errorContent = errorText == null
        ? null
        : Text(errorText, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(alignment: Alignment.center, content: errorContent ?? content?.getFullContent(context)),
    );
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        final shake = math.sin(_shakeAnimation.value * math.pi * 4) * 0.05;
        final scaleExtra = math.sin(math.pow(_highlightAnimation.value, 0.5) * math.pi);
        return Transform.scale(
          scale: 1 + (scaleExtra * 0.05),
          child: Transform.rotate(
            angle: shake,
            child: SizedBox(
              width: 80,
              height: 80,
              child: GestureDetector(
                onTap: _handleTap,
                child: AnimatedBuilder(
                  animation: _openCloseAnimation,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        // Background (what's behind the door)
                        _buildInnerContent(),
                        // The door itself
                        _buildDoor(scaleExtra),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInnerContent() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundLightColor,
        borderRadius: BorderRadius.circular(doorCorner),
        border: Border.all(color: backgroundDarkColor, width: doorBorderWidth),
      ),
      child: Container(
        margin: const EdgeInsets.all(innerContentMargin),
        decoration: BoxDecoration(color: backgroundDarkColor, borderRadius: BorderRadius.circular(innerContentCorner)),
        child: Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: ElevatedButton(
              onPressed: () => _showDoorDialog(widget.user, widget.doorNumber, widget.doorContent, context),
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundButtonColor,
                overlayColor: const Color.fromARGB(255, 221, 185, 161),
                shadowColor: Colors.black,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 8,
              ),
              child: Center(
                child: Text(
                  widget.doorContent?.taskID ?? noContentIcons[widget.doorNumber % noContentIcons.length],
                  style: const TextStyle(fontSize: 42),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoor(double scaleExtra) => Transform(
    alignment: Alignment.centerLeft,
    transform: Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(_openCloseAnimation.value * 3.1415926535897932 * (openDegree / 180)),
    child: Container(
      decoration: BoxDecoration(
        color: doorColor,
        borderRadius: BorderRadius.circular(doorCorner),
        border: Border.all(color: doorBorderColor, width: doorBorderWidth),
      ),
      child: Stack(
        children: [
          _drawOrnaments(),
          // Door inner
          if (oppennedDegree() > 90) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(width: 15, color: doorBorderColor),
                  horizontal: BorderSide(width: 1, color: doorBorderColor),
                ),
              ),
            ),
          ],
          if (oppennedDegree() < 90) ...[
            // Door panels (decorative lines)
            Container(
              margin: const EdgeInsets.all(oranment1Margin),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: doorOrnamentColor, width: oranmentWidth),
                borderRadius: BorderRadius.circular(oranment1Corner),
              ),
            ),
            // Glow effect
            if (widget.isOpenable) _buildGlow(),

            // Door number
            Transform.scale(
              scale: 1 + (scaleExtra * 0.5),
              child: Center(
                child: Text(
                  '${widget.doorNumber}',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: doorTextColor,
                    shadows: [Shadow(color: Colors.black.withAlpha(50), offset: const Offset(1, 1), blurRadius: 2)],
                  ),
                ),
              ),
            ),
            // Door knob
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: doorKnobColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 2, offset: const Offset(1, 1)),
                    ],
                  ),
                ),
              ),
            ),
            // Optional bottom text
            if (widget.doorContent?.bottomText != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 8,
                child: Center(
                  child: Text(
                    widget.doorContent!.bottomText!,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: doorTextColor,
                      shadows: [Shadow(color: Colors.black.withAlpha(50), offset: const Offset(1, 1), blurRadius: 2)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ],
      ),
    ),
  );

  Widget _drawOrnaments() => Padding(
    padding: const EdgeInsets.all(oranment1Margin),
    child: Padding(
      padding: const EdgeInsets.all(oranment2Margin * 2),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(oranment2Margin),
                    decoration: BoxDecoration(
                      border: Border.all(color: doorOrnamentColor, width: oranmentWidth),
                      borderRadius: BorderRadius.circular(oranment2Corner),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(oranment2Margin),
                    decoration: BoxDecoration(
                      border: Border.all(color: doorOrnamentColor, width: oranmentWidth),
                      borderRadius: BorderRadius.circular(oranment2Corner),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(oranment2Margin),
                    decoration: BoxDecoration(
                      border: Border.all(color: doorOrnamentColor, width: oranmentWidth),
                      borderRadius: BorderRadius.circular(oranment2Corner),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(oranment2Margin),
                    decoration: BoxDecoration(
                      border: Border.all(color: doorOrnamentColor, width: oranmentWidth),
                      borderRadius: BorderRadius.circular(oranment2Corner),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildGlow() {
    return SizedBox.shrink();
  }
}
