import 'package:flutter/cupertino.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';

class GlobalViewModel with ChangeNotifier {
  int _bottomNavIndex = 0;
  int _currentIndex = 0;

  setBottomNavIndex(int index, {int? currentIndex}) {
    _bottomNavIndex = index;

    currentIndex != null ? _currentIndex = currentIndex : _currentIndex = 0;

    notifyListeners();
  }

  int getBottomNavIndex() {
    return _bottomNavIndex;
  }

  int getCurrentNavIndex() {
    return _currentIndex;
  }
}
