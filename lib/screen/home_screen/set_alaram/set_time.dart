import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/theme/app_text_styles.dart';
import '../../../language/app_localization.dart';

class SetTime extends StatefulWidget {
  const SetTime({super.key});

  @override
  State<SetTime> createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(   AppLocalizations.of(context)!
                .translate('setTime')
                .toString(),
                textAlign: TextAlign.center,
                style: AppTextStyles.boldStyle.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  applyThemeToAll: false,
                  textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: AppTextStyles.boldStyle.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  )),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (newTime) {
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.45,
                height: MediaQuery.sizeOf(context).height * 0.16,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [Color(0xFF3BDEB4), Color(0xFF3BB6DE)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.50),
                  ),
                ),
                child: Center(
                  child: Text(
                      AppLocalizations.of(context)!
                          .translate('save')
                          .toString(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.boldStyle.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

