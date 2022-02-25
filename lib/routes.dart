import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trendee_moviez/views/favourites.dart';
import 'package:trendee_moviez/views/home.dart';
import 'package:trendee_moviez/views/more.dart';

class Routes {
  Routes._();

  static const String home = '/views/home';
  static const String more = '/views/more';
  static const String favorites = '/views/favourites';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case more:
        return MaterialPageRoute(builder: (_) => MoreScreen());
      case favorites:
        return MaterialPageRoute(builder: (_) => FavouriteScreen());

      default:
        return errorRoute();
    }
  }

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
