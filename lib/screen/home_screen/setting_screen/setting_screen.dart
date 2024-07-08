import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:namaz_app/screen/select_language/language.dart';
import 'package:namaz_app/veriable/veriable.dart';
import 'package:provider/provider.dart';

import '../../../language/app_localization.dart';
import '../../../theme/app_text_styles.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Center(
              child: Text(
                  AppLocalizations.of(context)!.translate('settings').toString(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.boldStyle.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 6),
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
                  const Image(
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/language.png"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      AppLocalizations.of(context)!
                          .translate('changeLanguage')
                          .toString(),
                      style: AppTextStyles.boldStyle.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Language()));
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xF20F5F5F5),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
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
                  const Image(
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/roko.png")),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .translate('rafalYadayn')
                                    .toString(),
                                style: AppTextStyles.boldStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                )),
                            FlutterSwitch(
                              width: 31.0,
                              height: 18.0,
                              inactiveToggleColor: const Color(0xFFFFFFFF),
                              inactiveColor: const Color(0xf20FFFFFF),
                              activeToggleColor: const Color(0xFF1B4440),
                              activeColor: Colors.white,
                              inactiveText: '',
                              activeText: '',
                              toggleSize: 14.0,
                              value: variable.isAhlHadith,
                              borderRadius: 30.0,
                              showOnOff: false,
                              onToggle: (v) {
                                setState(() {
                                variable.isAhlHadith=!variable.isAhlHadith;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                            AppLocalizations.of(context)!
                                .translate('raisingHandsInRukuk')
                                .toString(),
                            style: AppTextStyles.boldStyle.copyWith(
                              color: const Color(0xFFABADB4),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
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
