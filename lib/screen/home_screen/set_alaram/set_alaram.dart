import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Alarm {
  DateTime time;
  bool isActive;

  Alarm({required this.time, this.isActive = false});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      time: DateTime.parse(json['time']),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'isActive': isActive,
    };
  }
}

class AlarmHomePage extends StatefulWidget {
  @override
  _AlarmHomePageState createState() => _AlarmHomePageState();
}

class _AlarmHomePageState extends State<AlarmHomePage> {
  List<Alarm> alarms = [];
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _loadAlarms();
  }

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsJson = prefs.getStringList('alarms') ?? [];

    setState(() {
      alarms = alarmsJson.map((alarmJson) => Alarm.fromJson(jsonDecode(alarmJson))).toList();
    });
  }

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsJson = alarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await prefs.setStringList('alarms', alarmsJson);
  }

  Future<void> _scheduleAlarm(DateTime scheduledTime, int index) async {
    final androidDetails = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('takbber_1'),
    );
    final iOSDetails = IOSNotificationDetails(sound: 'takbber_1');
    final platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationsPlugin.schedule(
      index,
      'Alarm',
      'It\'s time!',
      scheduledTime,
      platformDetails,
    );
  }

  void _deleteAlarm(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Alarm'),
          content: const  Text('Are you sure you want to delete this alarm?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:const  Text('Delete'),
              onPressed: () {
                setState(() {
                  flutterLocalNotificationsPlugin.cancel(index);
                  alarms.removeAt(index);
                  _saveAlarms();
                  Navigator.of(context).pop(); // Close the dialog
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      appBar: AppBar(
        title: const Center(child: Text('Alarm')),
      ),
      body: alarms.isEmpty
          ? const Center(child: Text('No alarms set.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: alarms.length,
                    itemBuilder: (context, index) {
                      final alarm = alarms[index];
                      return Dismissible(
                        key: Key(alarm.time.toIso8601String()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _deleteAlarm(index);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          onTap: () {
                            _deleteAlarm(index); // Tap on ListTile to delete alarm
                          },
                          title: Text(DateFormat('hh:mm a').format(alarm.time)),
                          trailing: Switch(
                            value: alarm.isActive,
                            onChanged: (value) {
                              setState(() {
                                alarm.isActive = value;
                                if (value) {
                                  _scheduleAlarm(alarm.time, index);
                                } else {
                                  flutterLocalNotificationsPlugin.cancel(index);
                                }
                                _saveAlarms();
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const   Divider(height: 0), // Divider between list and floating action button
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            helpText: 'Select alarm time',
            cancelText: 'Cancel',
          );

          if (time != null) {
            final now = DateTime.now();
            final alarmTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
            setState(() {
              alarms.add(Alarm(
                time: alarmTime,
                isActive: true,
              ));
            });
            _scheduleAlarm(alarmTime, alarms.length - 1);
            _saveAlarms();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AlarmHomePage(),
  ));
}
