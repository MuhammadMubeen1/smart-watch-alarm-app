import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Alarm {
  DateTime time;
  bool isActive;

  Alarm({
    required this.time,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      time: DateTime.parse(json['time']),
      isActive: json['isActive'],
    );
  }
}
