import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/constants/strings.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    MoviesViewModel? _moviesModel = Provider.of<MoviesViewModel>(
      context,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /////// Title ..................
            Container(
                padding: EdgeInsets.only(
                    top: DeviceUtils.getScaledHeight(context, 0.05),
                    bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                child: TextView(
                  text: _moviesModel.selectedMovie!.title ?? '',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
