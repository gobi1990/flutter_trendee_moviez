import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/constants/strings.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/poster_image_card.dart';
import 'package:trendee_moviez/views/widgets/star_rating_bar.dart';
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

    GlobalViewModel _globalModel = Provider.of<GlobalViewModel>(
      context,
    );

    Movie? _selectedMovie = _moviesModel.selectedMovie;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      onPressed: () {
                        _globalModel.setBottomNavIndex(0);
                      },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        size: 35,
                      ),
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        size: 30,
                      ),
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            PosterImageCard(
              imageUrl: _selectedMovie != null
                  ? (_selectedMovie.posterPath != null
                      ? '${APIConfig.image_poster_url}${_selectedMovie.posterPath}'
                      : Assets.image_not_available)
                  : Assets.image_not_available,
            ),
            /////// Title ..................
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextView(
                  text: _selectedMovie?.title ?? '',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                )),
            ////////////// Star Rating Bar ..............
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: StarRatingBar(
                itemSize: 25,
                rating: (_selectedMovie?.voteAverage != null &&
                        _selectedMovie?.voteAverage != 0)
                    ? double.parse((_selectedMovie?.voteAverage).toString()) / 2
                    : 0,
              ),
            ),
            Container(
              width: DeviceUtils.getScaledWidth(context, 1),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                direction: Axis.horizontal,
                children: [
                  _buildExtraDetails('Language',
                      _selectedMovie?.originalLanguage?.toUpperCase()),
                  _buildExtraDetails(
                      'Release', _selectedMovie?.releaseDate ?? ''),
                ],
              ),
            ),
            /////// Title ..................
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextView(
                  text: _selectedMovie?.overview ?? '',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.justify,
                )), //
          ],
        ),
      ),
    );
  }

  Widget _buildExtraDetails(String? title, String? subtitle) {
    return Container(
      width: 200,
      child: Column(
        children: [
          /////// Title ..................
          Container(
              padding: EdgeInsets.only(
                  top: DeviceUtils.getScaledHeight(context, 0.02),
                  bottom: DeviceUtils.getScaledHeight(context, 0.01)),
              child: TextView(
                text: title ?? '',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )), /////// Title ..................
          Container(
              child: TextView(
            text: subtitle ?? '',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
        ],
      ),
    );
  }
}
