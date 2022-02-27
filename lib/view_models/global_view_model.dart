import 'package:flutter/cupertino.dart';

class GlobalViewModel with ChangeNotifier {
  int _bottomNavIndex = 0;

  setBottomNavIndex(int index) {
    _bottomNavIndex = index;
    notifyListeners();
  }

  int getBottomNavIndex() {
    return _bottomNavIndex;
  }
}
