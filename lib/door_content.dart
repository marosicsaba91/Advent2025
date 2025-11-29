import 'package:flutter/widgets.dart';

import 'main.dart';

class DoorContent {
  final Widget child;
  final String icon;

  const DoorContent({required this.icon, required this.child});
}


class DoorContentManager {
  static Map<(int, User), DoorContent> content = {
    (1, User.dorkaMate): DoorContent(
      icon: "🕯️",
      child: _buildSimpleTextMessage(
        "🎄 Welcome to the Advent Calendar! Let the holiday magic begin!",
      ),
    ),
    (2, User.dorkaMate): DoorContent(
      icon: "❄️",
      child: _buildSimpleTextMessage(
        "☃️ Embrace the chill and let the winter wonderland fill your heart with joy!",
      ),
    ),
    (3, User.dorkaMate): DoorContent(
      icon: "🎁",
      child: _buildSimpleTextMessage(
        "🎉 Unwrap the joy of giving and receiving this holiday season!",
      ),
    ),
  };

  static Widget _buildSimpleTextMessage(String message) {
    return Text(message, style: const TextStyle(fontSize: 18));
  }
}
