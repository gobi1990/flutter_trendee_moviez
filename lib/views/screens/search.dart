import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/views/widgets/list_item_card.dart';
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 0.07),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: Offset(2, 3),
                            color: Colors.black.withOpacity(0.1))
                      ]),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        width: DeviceUtils.getScaledWidth(context, 0.7),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Search a movie...'),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.search)))
                    ],
                  )),
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: ListItemCard());
                  }))
        ],
      ),
    );
  }
}
