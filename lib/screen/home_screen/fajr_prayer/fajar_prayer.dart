import 'package:flutter/material.dart';
import 'package:namaz_app/screen/home_screen/fajr_prayer/steps/step_one.dart';

import '../../../language/app_localization.dart';
import '../../../theme/app_text_styles.dart';

class FajarPrayer extends StatelessWidget {
  const FajarPrayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                 children: [
                   SizedBox(height: 20,),
                    CircleAvatar(backgroundColor: const Color(0xf20FFFFFF),child: Image.asset(
                        color: Colors.white,
                        height: 20,
                        width: 20,
                        'assets/images/fajar.png'),),
                    const SizedBox(height: 10,),
                    Text(
                        AppLocalizations.of(context)!
                            .translate('fajr')
                            .toString(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.boldStyle.copyWith(     color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,)
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      width: double.infinity,
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: const Color(0xF200E0E0E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('2sunnah')
                                  .toString(),
                              style:AppTextStyles.boldStyle.copyWith(      color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,)
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StepOne()));
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor:  Color(0xF20F5F5F5),
                              child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 10,),
                            ),
                          ),


                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: ShapeDecoration(
                        color: const Color(0xF200E0E0E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('2fard')
                                  .toString(),
                              style:AppTextStyles.boldStyle.copyWith(      color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,)
                          ),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor:  Color(0xF20F5F5F5),
                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 10,),
                          ),


                        ],
                      ),
                    ),
                   const SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
