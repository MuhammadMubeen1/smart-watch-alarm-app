import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/screen/home_screen/fajr_prayer/fajar_prayer.dart';
import 'package:namaz_app/theme/app_text_styles.dart';

import '../../../language/app_localization.dart';

class AllPrayerGuide extends StatefulWidget {
  const AllPrayerGuide({super.key});

  @override
  State<AllPrayerGuide> createState() => _AllPrayerGuideState();
}

class _AllPrayerGuideState extends State<AllPrayerGuide> {
  List<String> imgPaths = [
    'assets/images/add.png',
    'assets/images/fajar.png',
    'assets/images/zuhar.png',
    'assets/images/asar.png',
    'assets/images/maghrib.png',
    'assets/images/esha.png',
  ];
  List<String> names = [
    'add',
    'fajr',
    'dhuhar',
    'asar',
    'maghrib',
    'esha',
  ];
  final List bgColor = [
    const Color(0xf200E0E0E),
    const Color(0xf20FFFFFF),
    const Color(0xf20FFFFFF),
    const Color(0xf20FFFFFF),
    const Color(0xf20FFFFFF),
    const Color(0xf20FFFFFF),
  ];

  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1,
        height: MediaQuery.sizeOf(context).height * 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xff1E5648),
              Color(0xFF1E4957)],
          ),
        ),
        child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleList(
              outerRadius: 98,
              origin: const Offset(0, 0),
              centerWidget: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Image.asset(
                    height: 20,
                    width: 20,
                    "assets/images/Group 1000006031.png",
                    scale: 1.30,
                  )),
              children: List.generate(
                imgPaths.length,
                (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex=index;
                        _currentIndex==1?Navigator.push(context, MaterialPageRoute(builder: (context)=> const FajarPrayer())):null;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: bgColor[index], shape: BoxShape.circle,
                          border: Border.all(color: _currentIndex==index?Colors.white:Colors.transparent)
                          ),

                          child: Image.asset(
                              color: Colors.white,
                              height: 20,
                              width: 20,
                              imgPaths[index]),
                        ),
                        SizedBox(height: 3,),
                        Expanded(
                          child: Text(
                              AppLocalizations.of(context)!
                                  .translate(names[index])
                                  .toString(),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.boldStyle.copyWith(    color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,)
                          ),
                        )

                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
