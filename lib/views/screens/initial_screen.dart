import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/routes.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/views/widgets/bottom_navbar_item.dart';

//////////////////// Initial Screen with Bottom navigation bar.......
class InitialScreen extends StatefulWidget {
  InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalViewModel _globalModel = Provider.of<GlobalViewModel>(context);
    return Scaffold(
        bottomNavigationBar: Stack(
          children: [
            _buildBottomNavigation(_globalModel),
          ],
        ),
        body: Stack(children: [
          IndexedStack(
            index: _globalModel.getBottomNavIndex(),
            children: Routes.bottommNavigationScreens,
          )
        ]));
  }

  Widget _buildBottomNavigation(GlobalViewModel _globalModel) {
    return Container(
        height: 83,
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ), //MediaQuery.of(context).viewPadding.bottom),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  blurRadius: 6,
                  offset: Offset(0, 1))
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavBarItem(
                title: 'Home',
                itemIndex: 0,
                inactiveIcon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                currentIndex: _globalModel.getBottomNavIndex(),
                onTapAction: (a) {
                  _globalModel.setBottomNavIndex(a);
                }),
            BottomNavBarItem(
                title: 'Favorites',
                itemIndex: 1,
                activeIcon: Icon(Icons.favorite),
                inactiveIcon: Icon(Icons.favorite_border),
                currentIndex: _globalModel.getBottomNavIndex(),
                onTapAction: (a) {
                  _globalModel.setBottomNavIndex(a);
                }),
            BottomNavBarItem(
                title: 'More',
                itemIndex: 2,
                activeIcon: Icon(Icons.menu),
                inactiveIcon: Icon(Icons.menu),
                currentIndex: _globalModel.getBottomNavIndex(),
                onTapAction: (a) {
                  _globalModel.setBottomNavIndex(a);
                }),
          ],
        ));
  }
}
