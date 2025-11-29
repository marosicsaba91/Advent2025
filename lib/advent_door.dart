import 'package:flutter/material.dart';
import 'dart:math' as math;

class AdventDoor extends StatefulWidget {
  final int doorNumber;
  final String doorIcon;
  final bool isOpenable;
  final bool isOpened;
  final VoidCallback onTap;
  final VoidCallback onIconTap;

  const AdventDoor({
    super.key,
    required this.doorNumber,
    required this.doorIcon,
    required this.isOpenable,
    required this.isOpened,
    required this.onTap,
    required this.onIconTap,
  });

  @override
  State<AdventDoor> createState() => _AdventDoorState();
}

class _AdventDoorState extends State<AdventDoor>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  Color get doorColor => (widget.isOpenable)
      ? Color.fromARGB(255, 235, 61, 61)
      : Color.fromARGB(255, 182, 74, 74);
  Color get doorBorderColor => (widget.isOpenable)
      ? const Color.fromARGB(255, 131, 27, 27)
      : const Color.fromARGB(255, 99, 30, 30);
  Color get doorOrnamentColor => (widget.isOpenable)
      ? const Color.fromARGB(255, 211, 51, 51)
      : const Color.fromARGB(255, 170, 62, 62);
  Color get doorTextColor => (widget.isOpenable)
      ? const Color.fromARGB(255, 255, 255, 255)
      : const Color.fromARGB(255, 255, 178, 155);
  Color get doorKnobColor => (widget.isOpenable)
      ? const Color.fromARGB(255, 255, 195, 91)
      : const Color.fromARGB(255, 238, 151, 0);

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

  double oppennedDegree() => _animation.value * openDegree;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1, // degrees to open
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    if (widget.isOpened) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AdventDoor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpened != oldWidget.isOpened) {
      if (widget.isOpened) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isOpenable) {
      widget.onTap();
    } else {
      _shakeController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        final shake = math.sin(_shakeAnimation.value * math.pi * 3) * 5;
        return Transform.translate(
          offset: Offset(shake, 0),
          child: SizedBox(
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: _handleTap,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    children: [
                      // Background (what's behind the door)
                      _buildInnerContent(),
                      // The door itself
                      _buildDoor(),
                    ],
                  );
                },
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
        decoration: BoxDecoration(
          color: backgroundDarkColor,
          borderRadius: BorderRadius.circular(innerContentCorner),
        ),
        child: Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: ElevatedButton(
              onPressed: widget.onIconTap,
              style: ElevatedButton.styleFrom(
                backgroundColor:backgroundButtonColor,
                overlayColor:  const Color.fromARGB(255, 221, 185, 161),
                shadowColor: Colors.black,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
              ),
              child: Center(
                child: Text(
                  widget.doorIcon,
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

  Widget _buildDoor() => Transform(
    alignment: Alignment.centerLeft,
    transform: Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(_animation.value * 3.1415926535897932 * (openDegree / 180)),
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
                border: Border.all(
                  color: doorOrnamentColor,
                  width: oranmentWidth,
                ),
                borderRadius: BorderRadius.circular(oranment1Corner),
              ),
            ),
            // Door number
            Center(
              child: Text(
                '${widget.doorNumber}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: doorTextColor,
                  shadows: [
                    Shadow(
                      color: Colors.black.withAlpha(50),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
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
                      BoxShadow(
                        color: Colors.black.withAlpha(100),
                        blurRadius: 2,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
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
                      border: Border.all(
                        color: doorOrnamentColor,
                        width: oranmentWidth,
                      ),
                      borderRadius: BorderRadius.circular(oranment2Corner),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(oranment2Margin),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: doorOrnamentColor,
                        width: oranmentWidth,
                      ),
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
                      border: Border.all(
                        color: doorOrnamentColor,
                        width: oranmentWidth,
                      ),
                      borderRadius: BorderRadius.circular(oranment2Corner),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(oranment2Margin),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: doorOrnamentColor,
                        width: oranmentWidth,
                      ),
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
}
