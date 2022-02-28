import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/routes.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/screens/initial_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalViewModel()),
        ChangeNotifierProvider(create: (_) => MoviesViewModel())
      ],
      child: MaterialApp(
        title: 'Trendee Moviez',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InitialScreen(),
        routes: Routes.routes,
      ),
    );
  }
}
