import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)))
              ],
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 300,
                      height: 60,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextView(text: 'Title', fontSize: 20)),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child:
                                      TextView(text: 'SubTitle', fontSize: 18)),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Text(
              'Popular Movies',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
