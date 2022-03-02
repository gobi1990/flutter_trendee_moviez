import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/constants/strings.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /////// Title ..................
            Container(
                padding: EdgeInsets.only(
                    top: DeviceUtils.getScaledHeight(context, 0.05),
                    bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                child: TextView(
                  text: Strings.more,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
