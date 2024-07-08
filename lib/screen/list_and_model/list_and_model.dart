// All App List
final List languageList=[
  'Turkish',
  'Arabic',
  'English',
  'German',
  'France'
];
final List languageListCode=[
  'tr',
  'ar',
  'en',
  'de',
  'fr'
];

final List<HomeModel> homeData=[
  HomeModel(icon:'assets/images/Vector.png', title: 'allPrayersGuide'),
  HomeModel(icon: 'assets/images/2.png', title: 'setPrayerAlarm'),
  HomeModel(icon: 'assets/images/3.png', title: 'settings'),
];
final List<AlarmModel> alarmData=[
  AlarmModel(icon: 'assets/images/fajar.png', title: '04:35', subtitle: 'fajr'),
  AlarmModel(icon: 'assets/images/zuhar.png', title: '01:35', subtitle: 'dhuhar'),
  AlarmModel(icon: 'assets/images/asar.png', title: '04:50', subtitle: 'asar'),
  AlarmModel(icon: 'assets/images/maghrib.png', title: '06:10', subtitle: 'maghrib'),
  AlarmModel(icon: 'assets/images/esha.png', title: '07:30', subtitle: 'esha'),
];

// Model

class HomeModel{
  String icon;
  String title;
  HomeModel({required this.icon, required this.title});
}

class AlarmModel{
  String icon;
  String title;
  String subtitle;
  AlarmModel({required this.icon, required this.title, required this.subtitle,});
}