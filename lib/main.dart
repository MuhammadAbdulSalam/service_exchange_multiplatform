import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/animation.dart';
import 'package:service_exchange_multiplatform/ui/homepage/ControllerActivity.dart';
import 'package:service_exchange_multiplatform/utils/Constants.dart';
import 'package:service_exchange_multiplatform/utils/FirebaseCallHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/homepage/LandingActivity.dart';
import 'ui/loginviews/LoginActivity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(new MaterialApp(
    home: new SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  FirebaseCallHelper firebaseCallHelper = FirebaseCallHelper();

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void setUserTheme() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      Constants.IS_THEME_DARK =
          await prefs.getBool(Constants.COLOR_THEME) ?? false;
      if (Constants.IS_THEME_DARK) {
        Constants.homeThemeDark();
      } else {
        Constants.homeThemeLight();
      }
    } catch (Exception) {}
  }

  void navigationPage() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    try {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ControllerActivity()),
            ModalRoute.withName("/Home"));
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginActivity()),
            ModalRoute.withName("/Home"));
      }
    } catch (Exception) {}
  }

  //Animation
  Animation<double> backgroundAnimation;

  AnimationController _backgroundController;

  // list of bubble widgets shown on screen
  final bubbleWidgets = List<Widget>();

  // flag to check if the bubbles are already present or not.
  bool areBubblesAdded = false;

  Animatable<Color> backgroundDark = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Constants.DEFAULT_BLUE,
        end: Constants.DEFAULT_ORANGE,
      ),
    ),
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Constants.DEFAULT_ORANGE,
        end: Constants.DEFAULT_BLUE,
      ),
    ),
  ]);
  Animatable<Color> backgroundNormal = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Constants.DEFAULT_BLUE,
        end: Constants.DEFAULT_ORANGE,
      ),
    ),
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Constants.DEFAULT_ORANGE,
        end: Constants.DEFAULT_BLUE,
      ),
    ),
  ]);
  Animatable<Color> backgroundLight = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Constants.BLUE_SHADE_2,
        end: Constants.ORANGE_SHADE_2,
      ),
    ),
    TweenSequenceItem(
      weight: 0.5,
      tween: ColorTween(
        begin: Constants.ORANGE_SHADE_2,
        end: Constants.BLUE_SHADE_2,
      ),
    ),
  ]);

  AlignmentTween alignmentTop =
      AlignmentTween(begin: Alignment.topRight, end: Alignment.topLeft);
  AlignmentTween alignmentBottom =
      AlignmentTween(begin: Alignment.bottomRight, end: Alignment.bottomLeft);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    setUserTheme();

    if (FirebaseAuth.instance.currentUser != null) {
      firebaseCallHelper.getUserList().then((value) {
        Constants.userList = value;
      });
    }

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    backgroundAnimation =
        CurvedAnimation(parent: _backgroundController, curve: Curves.easeIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                _backgroundController.forward(from: 0);
              });
            }
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _backgroundController.forward(from: 0);
              });
            }
          });

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // Add below to add bubbles intially.

    return AnimatedBuilder(
      animation: backgroundAnimation,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: alignmentTop.evaluate(backgroundAnimation),
                        end: alignmentBottom.evaluate(backgroundAnimation),
                        colors: [
                          backgroundDark.evaluate(backgroundAnimation),
                          backgroundNormal.evaluate(backgroundAnimation),
                          backgroundLight.evaluate(backgroundAnimation),
                        ],
                      ),
                    ),
                  ),
                ] +
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: new Image.asset("images/logo_main.png",
                              width: 170, height: 170)),
                    ],
                  ),
                ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _backgroundController.dispose();
  }
}
