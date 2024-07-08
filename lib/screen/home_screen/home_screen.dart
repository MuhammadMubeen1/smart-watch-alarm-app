import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:namaz_app/screen/home_screen/set_alaram/set_alaram.dart';
import 'package:namaz_app/screen/home_screen/setting_screen/setting_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../language/app_localization.dart';
import '../../theme/app_text_styles.dart';
import '../list_and_model/list_and_model.dart';
import 'all_prayer_guide/all_prayer_guide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String formattedTime = "";
  String formattedDate = "";
  String currentTimeZone = "";
  late Position _currentPosition;
  String _prayerTimes = '';

  Map<String, String> prayerTimes = {};

  @override
  void initState() {
    super.initState();
    timeZone(); // Initial call to set the initial time and timezone
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => updateTime());
    _currentPosition = Position(
      latitude: 0.0,
      longitude: 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
    _getCurrentLocation();
    timeZone();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _fetchPrayerTimes(); // Fetch prayer times after setting position
      });
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        _prayerTimes = 'Error getting location: $e';
      });
    }
  }

  void _fetchPrayerTimes() async {
    try {
      final latitude = _currentPosition.latitude;
      final longitude = _currentPosition.longitude;
      final response = await http.get(Uri.parse(
          'http://api.aladhan.com/v1/calendar?latitude=$latitude&longitude=$longitude&method=2'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var allPrayerTimes =
            Map<String, String>.from(data['data'][0]['timings']);

        // Filter out "Sunset" and "Sunrise" times
        prayerTimes = allPrayerTimes
          ..removeWhere((key, value) => key == 'Sunset' || key == 'Sunrise');

        setState(() {});
      } else {
        setState(() {
          _prayerTimes =
              'Failed to fetch prayer times (${response.statusCode})';
        });
      }
    } catch (e) {
      print("Error fetching prayer times: $e");
      setState(() {
        _prayerTimes = 'Error fetching prayer times: $e';
      });
    }
  }

  String getCurrentPrayerName() {
    DateTime now = DateTime.now();
    String currentPrayer = "";
    List<String> specificPrayers = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    for (String prayer in prayerTimes.keys) {
      if (specificPrayers.contains(prayer)) {
        DateTime prayerDateTime =
            DateFormat("HH:mm").parse(prayerTimes[prayer]!);
        DateTime prayerTimeToday = DateTime(now.year, now.month, now.day,
            prayerDateTime.hour, prayerDateTime.minute);

        if (prayerTimeToday.isBefore(now) ||
            prayerTimeToday.isAtSameMomentAs(now)) {
          currentPrayer = prayer;
        } else {
          break;
        }
      }
    }

    return currentPrayer;
  }

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void timeZone() async {
    currentTimeZone = await FlutterTimezone.getLocalTimezone();
    updateTime();
  }

  void updateTime() {
    DateTime now = DateTime.now();
    setState(() {
      formattedTime = DateFormat('kk:mm').format(now);
      formattedDate = DateFormat('MMM dd, yyyy').format(now);
    });
  }

  Gradient getContainerColor(int index, List<String> prayerNames) {
    String currentPrayer = getCurrentPrayerName();
    int currentIndex = prayerNames.indexOf(currentPrayer);

    if (currentPrayer.isEmpty) {
      // Default gradient for future prayers if no current prayer found
      return const LinearGradient(
        colors: [Color(0xF200E0E0E), Color(0xF200E0E0E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    if (index < currentIndex) {
      // Past prayers
      return const LinearGradient(
        colors: [Colors.white, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (index == currentIndex) {
      // Current prayer
      return const LinearGradient(
        colors: [Color(0xff3BB7DE), Color(0xFF3BDEB4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (index > currentIndex && index <= currentIndex + 1) {
      // Next upcoming prayers
      return const LinearGradient(
        colors: [Color(0xF200E0E0E), Color(0xF200E0E0E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      // Future prayers after the next upcoming
      return const LinearGradient(
        colors: [Color(0xF200E0E0E), Color(0xF200E0E0E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> prayerNames = prayerTimes.keys.toList();

    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1,
        height: MediaQuery.sizeOf(context).height * 1,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xff1E5648), Color(0xFF1E4957)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: getCurrentPrayerName() == 'Fajr'
                            ? const AssetImage("assets/images/fajar.png")
                            : getCurrentPrayerName() == 'Dhuhr'
                                ? const AssetImage(
                                    "assets/images/zuhar.png")
                                : getCurrentPrayerName() == 'Asr'
                                    ? const AssetImage(
                                        "assets/images/asar.png")
                                    : getCurrentPrayerName() == 'Maghrib'
                                        ? const AssetImage(
                                            "assets/images/maghrib.png")
                                        : const AssetImage(
                                            "assets/images/esha.png"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        getCurrentPrayerName(),
                        style: AppTextStyles.boldStyle.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print(formattedTime);
                              },
                              child: Text(
                                formattedTime,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  currentTimeZone,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 2,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  formattedDate,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Time and Date Column ends
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Expanded(
                        child: Container(
                          height: 9,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: getContainerColor(index, prayerNames),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      homeData.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => index == 0
                                  ? const AllPrayerGuide()
                                  : index == 1
                                      ?  AlarmHomePage()
                                      : const SettingScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: ShapeDecoration(
                            color: const Color(0xF200E0E0E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                  height: 25,
                                  width: 25,
                                  image: AssetImage(homeData[index].icon)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .translate(homeData[index].title)
                                        .toString(),
                                    style: AppTextStyles.boldStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const CircleAvatar(
                                radius: 15,
                                backgroundColor: Color(0xF20F5F5F5),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
