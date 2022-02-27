import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class BackDropCard extends StatefulWidget {
  BackDropCard({Key? key}) : super(key: key);

  @override
  State<BackDropCard> createState() => _BackDropCardState();
}

class _BackDropCardState extends State<BackDropCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.yellow,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                spreadRadius: 2,
                offset: Offset(2, 3),
                color: Colors.black.withOpacity(0.1))
          ]),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextView(text: 'Title', fontSize: 20)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextView(text: 'SubTitle', fontSize: 18)),
            ],
          )
        ],
      ),
    );
  }
}
