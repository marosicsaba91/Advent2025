import 'package:advent/time.dart';
import 'package:advent/util.dart';
import 'package:flutter/material.dart';

class SiderealTimeWidget extends StatefulWidget {
  const SiderealTimeWidget({super.key});

  @override
  State<SiderealTimeWidget> createState() => SiderealTimeWidgetState();
}

class SiderealTimeWidgetState extends State<SiderealTimeWidget> {
  late Time _siderealTime;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
    // Update every second
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        _updateTime();
        return true;
      }
      return false;
    });
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now();
      _siderealTime = Util.calculateLocalSiderealTime(Util.budapestLongitude, _currentTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    final timeStr = _siderealTime.toNiceString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.black.withAlpha(150), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Budapesti sziderikus idő', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 10)),
          Text(
            timeStr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
