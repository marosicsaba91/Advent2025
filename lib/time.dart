import 'dart:math';

class Time {
  final int hours;
  final int minutes;
  final double seconds;

  Time(this.hours, this.minutes, this.seconds);
  Time.fromDateTime(DateTime dateTime) : this(dateTime.hour, dateTime.minute, dateTime.second.toDouble());

  Duration difference(Time other) {
    final thisInSeconds = hours * 3600 + minutes * 60 + seconds;
    final otherInSeconds = other.hours * 3600 + other.minutes * 60 + other.seconds;
    return Duration(seconds: (thisInSeconds - otherInSeconds).round());
  }

  Duration differenceAbs(Time other) {
    double thisInSeconds = hours * 3600 + minutes * 60 + seconds;
    double otherInSeconds = other.hours * 3600 + other.minutes * 60 + other.seconds;
    double diff = (thisInSeconds - otherInSeconds).abs();
    diff = min(diff, 86400 - diff);
    
    return Duration(seconds: diff.round());
  }

  String toNiceString() =>
      '${hours.toString().padLeft(2, '0')}:'
      '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toInt().toString().padLeft(2, '0')}';
}
