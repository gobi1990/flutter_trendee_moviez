import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trendee_moviez/views/screens/cast_member_details.dart';

import 'package:trendee_moviez/views/screens/favourites.dart';
import 'package:trendee_moviez/views/screens/home.dart';
import 'package:trendee_moviez/views/screens/more.dart';
import 'package:trendee_moviez/views/screens/movie_details_screen.dart';
import 'package:trendee_moviez/views/screens/search.dart';

class Routes {
  Routes._();

  static const String home = '/views/screens/home';
  static const String more = '/views/screens/more';
  static const String favorites = '/views/screens/favourites';
  static const String search = '/views/screens/search';
  static const String moviedetail = '/views/screens/movie_details_screen';
  static const String castMember = '/views/screens/cast_member_details';

//////////// Navigation screens with botoom nav bar.............
  static final List<Widget> bottommNavigationScreens = [
    HomeScreen(),
    FavouriteScreen(),
    MoreScreen(),
    SearchScreen(),
    MovieDetailsScreen(),
    CastMemberDetailsScreen()
  ];

  static final routes = <String, WidgetBuilder>{
    search: (BuildContext context) => FavouriteScreen(),
    moviedetail: (BuildContext context) => MovieDetailsScreen()
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
      case moviedetail:
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen());
      case castMember:
        return MaterialPageRoute(builder: (_) => CastMemberDetailsScreen());
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
