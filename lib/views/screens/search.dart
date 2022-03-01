import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
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

  @override
  Widget build(BuildContext context) {
    MoviesViewModel _moviesModel = Provider.of<MoviesViewModel>(
      context,
    );

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 0.07),
          ),
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
                                _moviesModel.getSearchedMoviesListFromApi(
                                    _seachController.text);
                              },
                              icon: Icon(Icons.search)))
                    ],
                  )),
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _moviesModel.searchMovies.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceAround,
                            children: [
                              ListItemCard(
                                movieItem: _moviesModel.searchMovies[index],
                                index: index,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                width: DeviceUtils.getScaledWidth(context, 0.4),
                                child: Column(
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: TextView(
                                          text: _moviesModel
                                                  .searchMovies[index].title ??
                                              '',
                                          fontSize: 22,
                                          maxLines: 2,
                                          fontWeight: FontWeight.bold,
                                          textColor: Colors.black,
                                        )),
                                    Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: TextView(
                                          text: _moviesModel.searchMovies[index]
                                                  .overview ??
                                              '',
                                          fontSize: 14,
                                          maxLines: 8,
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    StarRatingBar(
                                      rating: (_moviesModel.searchMovies[index]
                                                      .voteAverage !=
                                                  null &&
                                              _moviesModel.searchMovies[index]
                                                      .voteAverage !=
                                                  0)
                                          ? double.parse((_moviesModel
                                                      .searchMovies[index]
                                                      .voteAverage! /
                                                  2)
                                              .toString())
                                          : 0,
                                    )
                                  ],
                                ),
                              )
                            ]));
                  }))
        ],
      ),
    );
  }
}
