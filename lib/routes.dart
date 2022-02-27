import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:trendee_moviez/views/screens/favourites.dart';
import 'package:trendee_moviez/views/screens/home.dart';
import 'package:trendee_moviez/views/screens/more.dart';
import 'package:trendee_moviez/views/screens/search.dart';

class Routes {
  Routes._();

  static const String home = '/views/screens/home';
  static const String more = '/views/screens/more';
  static const String favorites = '/views/screens/favourites';
  static const String search = '/views/screens/search';

//////////// Bottom Navigation screens.............
  static final List<Widget> bottommNavigationScreens = [
    HomeScreen(),
    FavouriteScreen(),
    MoreScreen(),
    SearchScreen()
  ];

  static final routes = <String, WidgetBuilder>{
    search: (BuildContext context) => FavouriteScreen()
  };

///////////// Screen route generator ..................
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case more:
        return MaterialPageRoute(builder: (_) => MoreScreen());
      case favorites:
        return MaterialPageRoute(builder: (_) => FavouriteScreen());
      case search:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      default:
        return errorRoute();
    }
  }

/////////////// Error on wrong route.................
  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error!'),
        ),
      );
    });
  }
}
