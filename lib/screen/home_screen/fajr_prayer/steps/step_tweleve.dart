import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radial_progress/radial_progress.dart';

class StepTwelve extends StatefulWidget {
  const StepTwelve({super.key});

  @override
  State<StepTwelve> createState() => _StepTwelveState();
}

class _StepTwelveState extends State<StepTwelve> {
  late AudioPlayer _audioPlayer;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAudioAndNavigate();
  }

  Future<void> _playAudioAndNavigate() async {
    try {
      // Play the audio from a URL (replace with your audio file URL)
      await _audioPlayer.setAsset("assets/audios/Takbber 1.mp3");

      _audioPlayer.play();

      // Listen for audio completion
      _audioPlayer.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          _navigateToNextScreen();
        }

      });

    } catch (e) {
      print('Error playing audio: $e');
      // Handle any errors, e.g., show a snackbar or log the error
    }
  }

  void _navigateToNextScreen() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const StepEleven()),
    // );
  }

  @override
  void dispose() {
    // Dispose of the audio player when no longer needed
    _audioPlayer.dispose();
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
              percent:1,
              diameter: 340,
              enableAnimation:true,
              animationDuration: Duration.zero,
              margin: const EdgeInsets.all(5),
              bgLineColor: const Color(0xf20FFFFFF),
              progressLineWidth: 5,
              progressLineColors: const [
                Colors.white
              ],
              startAngle: StartAngle.top,
              centerChild:Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    CircleAvatar(backgroundColor: const Color(0xf20FFFFFF),child: Image.asset(
                        color: Colors.white,
                        height: 20,
                        width: 20,
                        'assets/images/Volume Up.png'),),
                    const SizedBox(height: 5,),
                    const Expanded(child: Image(image: AssetImage("assets/images/6 Step- Qiyam.gif")))
               ,const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          )
      ),
    );

  }

}

