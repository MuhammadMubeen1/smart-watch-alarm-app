import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:namaz_app/screen/home_screen/fajr_prayer/steps/for_ali_hadith/allah-o-akbar.dart';
import 'package:namaz_app/screen/home_screen/fajr_prayer/steps/step_four.dart';
import 'package:namaz_app/theme/app_text_styles.dart';
import 'package:namaz_app/veriable/veriable.dart';
import 'package:radial_progress/radial_progress.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  @override

  late AudioPlayer _audioPlayer;

  late AudioPlayer _audioPlayerOne;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayerOne = AudioPlayer();
    _playAudioAndNavigate();
  }
  Future<void> _playAudioAndNavigateOne() async {
    try {
      // Play the audio from a URL (replace with your audio file URL)
      await _audioPlayerOne.setAsset("assets/audios/Surah An-Nas.mp3");

      _audioPlayerOne.play();

      // Listen for audio completion
      _audioPlayerOne.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          _navigateToNextScreen();
        }

      });

    } catch (e) {
      print('Error playing audio: $e');
      // Handle any errors, e.g., show a snackbar or log the error
    }
  }

  Future<void> _playAudioAndNavigate() async {
    try {
      // Play the audio from a URL (replace with your audio file URL)
      await _audioPlayer.setAsset("assets/audios/Surah Al-Fatiha 01.mp3");

      _audioPlayer.play();

      // Listen for audio completion
      _audioPlayer.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
            _playAudioAndNavigateOne();
        }

      });

    } catch (e) {
      print('Error playing audio: $e');
      // Handle any errors, e.g., show a snackbar or log the error
    }
  }

  void _navigateToNextScreen() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StepFour()),
      );
  }

  @override
  void dispose() {
    // Dispose of the audio player when no longer needed
    _audioPlayer.dispose();
    _audioPlayerOne.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.sizeOf(context).width * 1,
          height: MediaQuery.sizeOf(context).height * 1,
          padding: const EdgeInsets.all(7),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xff1E5648),
                Color(0xFF1E4957)],
            ),
          ),
          child:
          Center(
            child: RadialProgressWidget(
              percent: 0.2,
              diameter: 340,
              enableAnimation:true,
              margin: const EdgeInsets.all(5),
              animationDuration: Duration.zero,
              bgLineColor: const Color(0xf20FFFFFF),
              progressLineWidth: 5,
              progressLineColors: const [
                Colors.white
              ],
              startAngle: StartAngle.top,
              centerChild:Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    CircleAvatar(backgroundColor: const Color(0xf20FFFFFF),child: Image.asset(
                        color: Colors.white,
                        height: 20,
                        width: 20,
                        'assets/images/Volume Up.png'),),
                    const SizedBox(height: 5,),
                    const Spacer(),
                    Text(
                        'Recite of\nSurah Fatiha',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.boldStyle.copyWith( color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,)
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          )
      ),
    );

  }

}

