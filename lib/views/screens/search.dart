import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/list_item_card.dart';
import 'package:trendee_moviez/views/widgets/star_rating_bar.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _seachController = TextEditingController();
  MoviesViewModel? _moviesModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   _moviesModel = Provider.of<MoviesViewModel>(context, listen: false);
    // });

    // _moviesModel?.setSearchedMoviesList(_moviesModel!.popularMovies);
  }

  @override
  Widget build(BuildContext context) {
    // MoviesViewModel
    _moviesModel = Provider.of<MoviesViewModel>(
      context,
    );
    GlobalViewModel _globalModel =
        Provider.of<GlobalViewModel>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /////////// Search Text field ................
                Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 3,
                              offset: Offset(2, 3),
                              color: Colors.black.withOpacity(0.1))
                        ]),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                          width: DeviceUtils.getScaledWidth(context, 0.7),
                          child: TextFormField(
                            onChanged: (query) {
                              //   _moviesModel?.getSearchedMoviesListFromApi(query);
                            },
                            controller: _seachController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: ' Search a movie...'),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: IconButton(
                                onPressed: () {
                                  //////////// Search function from Movie view model.............
                                  _moviesModel?.getSearchedMoviesListFromApi(
                                      _seachController.text);
                                  //////// Hide Keyboard ..................
                                  DeviceUtils.hideKeyboard(context);
                                },
                                icon: Icon(Icons.search)))
                      ],
                    )),
              ],
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _moviesModel != null
                        ? _moviesModel?.searchMovies.length
                        : 0,
                    itemBuilder: (context, index) {
                      /////////////// Search Movie Item with Inkwell..........
                      return InkWell(
                        onTap: () {
                          _moviesModel?.setSelectedMovie(
                              _moviesModel!.searchMovies[index]);

                          _globalModel.setBottomNavIndex(4, currentIndex: 3);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.spaceAround,
                                children: [
                                  /////////// List Item Card with poster Image..........
                                  ListItemCard(
                                    movieItem:
                                        _moviesModel?.searchMovies[index],
                                    index: index,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    width: DeviceUtils.getScaledWidth(
                                        context, 0.4),
                                    child: Column(
                                      children: [
                                        /////////// Movie Title..............
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: TextView(
                                              text: _moviesModel
                                                      ?.searchMovies[index]
                                                      .title ??
                                                  '',
                                              fontSize: 20,
                                              maxLines: 2,
                                              fontWeight: FontWeight.bold,
                                              textColor: Colors.black,
                                            )),
                                        ////////// Movie Overview................
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: TextView(
                                              text: _moviesModel
                                                      ?.searchMovies[index]
                                                      .overview ??
                                                  '',
                                              fontSize: 14,
                                              maxLines: 6,
                                              fontWeight: FontWeight.w500,
                                              textColor: Colors.black,
                                              textAlign: TextAlign.justify,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        ///////////// Star Rating bar ............
                                        StarRatingBar(
                                          rating: (_moviesModel
                                                          ?.searchMovies[index]
                                                          .voteAverage !=
                                                      null &&
                                                  _moviesModel
                                                          ?.searchMovies[index]
                                                          .voteAverage !=
                                                      0)
                                              ? double.parse((_moviesModel
                                                          ?.searchMovies[index]
                                                          .voteAverage!)
                                                      .toString()) /
                                                  2
                                              : 0,
                                        )
                                      ],
                                    ),
                                  )
                                ])),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
