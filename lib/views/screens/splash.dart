import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/constants/strings.dart';
import 'package:trendee_moviez/routes.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/views/screens/initial_screen.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white38,
                // image: DecorationImage(
                //     fit: BoxFit.fill, image: AssetImage(Assets.splashBackground)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ////////////// App Icon................
                    Container(
                      padding: EdgeInsets.only(
                          bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                      child: Icon(
                        Icons.movie_filter_outlined,
                        size: 100,
                      ),
                    ),
                    //////////// App Title...............
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                DeviceUtils.getScaledWidth(context, 0.2)),
                        child: TextView(
                          text: Strings.app_name,
                          fontSize: 35,
                          maxLines: 2,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

/////////// Timer for 2000ms.................
  Timer startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

//////////// Navigation to Initial screen ...................
  void navigate() async {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.initial, (route) => false);
    });
  }
}
