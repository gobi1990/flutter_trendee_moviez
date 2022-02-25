import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/constants/assets.dart';

import 'widgets/bottom_navbar_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Stack(
          children: [
            _buildBottomNavigation(),
            // Positioned(
            //   child: Observer(builder: (_) {
            //     return Visibility(
            //         visible: _globalStore.showSubscriptionDialog,
            //         child: Container(
            //           width: double.infinity,
            //           height: 83,
            //           color: Colors.black.withOpacity(0.1),
            //         ));
            //   }),
            // )
          ],
        ),
        body: Container());
  }

  Widget _buildBottomNavigation() {
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
                activeIcon: Assets.bottom_navbar_icon_home,
                inactiveIcon: Assets.bottom_navbar_icon_home,
                currentIndex: 0, //_globalStore.bottmNavIndex,
                onTapAction: (a) {} //_globalStore.setbottmNavIndex,
                ),
            BottomNavBarItem(
                title: 'Home',
                itemIndex: 0,
                activeIcon: Assets.bottom_navbar_icon_home,
                inactiveIcon: Assets.bottom_navbar_icon_home,
                currentIndex: 0, //_globalStore.bottmNavIndex,
                onTapAction: (a) {} //_globalStore.setbottmNavIndex,
                ),
            BottomNavBarItem(
                title: 'Home',
                itemIndex: 0,
                activeIcon: Assets.bottom_navbar_icon_home,
                inactiveIcon: Assets.bottom_navbar_icon_home,
                currentIndex: 0, //_globalStore.bottmNavIndex,
                onTapAction: (a) {} //_globalStore.setbottmNavIndex,
                ),
          ],
        ));
  }
}
