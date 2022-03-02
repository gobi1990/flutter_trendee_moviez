import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/constants/strings.dart';
import 'package:trendee_moviez/models/cast.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/view_models/cast_view_model.dart';
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
  MoviesViewModel? _moviesModel;
  GlobalViewModel? _globalModel;
  CastViewModel? _castModel;
  Movie? _selectedMovie;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   _moviesModel = Provider.of<MoviesViewModel>(context, listen: false);

    // });
  }

  @override
  Widget build(BuildContext context) {
    _moviesModel = Provider.of<MoviesViewModel>(
      context,
    );

    _globalModel = Provider.of<GlobalViewModel>(
      context,
    );

    _castModel = Provider.of<CastViewModel>(
      context,
    );

    _selectedMovie = _moviesModel?.selectedMovie;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///////// Back Button.................
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        onPressed: () {
                          //////////// Check the previous screen and navigate back.............
                          _globalModel?.setBottomNavIndex(
                              _globalModel?.getCurrentNavIndex() != 0
                                  ? _globalModel!.getCurrentNavIndex()
                                  : 0);
                        },
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          size: 35,
                        ),
                        color: Colors.black,
                      ),
                    ),
                    ///////// Favourite Icon ..................
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        onPressed: () {
                          _moviesModel!
                              .addOrRemoveFavouriteList(_selectedMovie);
                        },
                        icon: Icon(
                          _moviesModel!.favouritesMovieIds
                                  .contains(_selectedMovie?.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 30,
                        ),
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              //////////// Poster Image ................
              PosterImageCard(
                heightScale: 0.5,
                imageUrl: _selectedMovie != null
                    ? (_selectedMovie?.posterPath != null
                        ? '${APIConfig.image_poster_url}${_selectedMovie?.posterPath}'
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
                    textColor: Colors.blueGrey,
                  )),
              ////////////// Star Rating Bar ..............
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: StarRatingBar(
                  itemSize: 25,
                  rating: (_selectedMovie?.voteAverage != null &&
                          _selectedMovie?.voteAverage != 0)
                      ? double.parse((_selectedMovie?.voteAverage).toString()) /
                          2
                      : 0,
                ),
              ),
              /////// Extra details ---- (Release , Langauge )............
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

              /////// Overview ..................
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: TextView(
                    text: _selectedMovie?.overview ?? '',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.justify,
                    textColor: Colors.blueGrey,
                  )),
              /////// Overview ..................
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextView(
                        text: 'Cast',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                      )),
                ],
              ),
              //////// Cast List ............
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: _buildCastListView(),
              ), //
            ],
          ),
        ),
      ),
    );
  }

////////// Extra Details .................
  Widget _buildExtraDetails(String? title, String? subtitle) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.4),
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
                fontWeight: FontWeight.w500,
              )), /////// Subtitle ..................
          Container(
              child: TextView(
            text: subtitle ?? '',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textColor: Colors.blueGrey,
          )),
        ],
      ),
    );
  }

/////////////////// Mvie Cast members horizontal list view ................
  Widget _buildCastListView() {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _moviesModel?.movieCastList.length,
              itemBuilder: (BuildContext context, int index) {
                ///////// Cast member Image with gesture detector.............
                return GestureDetector(
                  onTap: () async {
                    Cast? cast = _moviesModel?.movieCastList[index];
                    _castModel
                        ?.getCastMemberDetailsFromApi(cast!.id.toString());

                    _globalModel?.setBottomNavIndex(5, currentIndex: 4);
                  },
                  child: Container(
                    // height: 250,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: PosterImageCard(
                      borderRadius: 20,
                      heightScale: 0.1,
                      widthScale: 0.3,
                      shadowBlurRadius: 20,
                      shadowSpreadRadius: 3,
                      imageUrl:
                          '${APIConfig.image_profile_url}${_moviesModel?.movieCastList[index].profilePath}',
                    ),
                  ),
                );
              }),
          Visibility(
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.black,
              ),
            ),
            visible: _moviesModel!.loading,
          )
        ],
      ),
    );
  }
}
