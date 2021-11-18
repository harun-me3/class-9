
import 'package:class_9th_ncert_all/home/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
late AnimationController _controller;

   @override
  void initState() {
  
    _controller = AnimationController(
      duration: Duration(seconds: (2)),
      vsync: this,
    );
      super.initState();



  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width:MediaQuery.of(context).size.height * 0.25 ,
              child: Lottie.asset(
                'assets/header/Splashscreen.json',
                repeat: true,
                controller: _controller,
               
                animate: true,
                onLoaded: (composition) {
                  print('Splash Screen is now loaded');
                 _controller
                ..duration = composition.duration
                ..forward().whenComplete(() => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>Home()),
                    )
                    
                    );
                },


              ),
            ),

          SizedBox(height: 10,),
             Text('''Virtual Study
NCERT Class 9th''',
              textAlign: TextAlign.center,
                style: Theme.of(context).accentTextTheme.headline1,
              )
            
          ],
        ),
      ),
    );
  }
}