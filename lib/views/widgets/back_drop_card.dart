import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class BackDropCard extends StatefulWidget {
  final int? index;
  final Movie? movieItem;
  BackDropCard({
    Key? key,
    this.index,
    this.movieItem,
  }) : super(key: key);

  @override
  State<BackDropCard> createState() => _BackDropCardState();
}

class _BackDropCardState extends State<BackDropCard> {
  @override
  Widget build(BuildContext context) {
    GlobalViewModel _globalModel =
        Provider.of<GlobalViewModel>(context, listen: false);
    MoviesViewModel _moviesModel = Provider.of<MoviesViewModel>(
      context,
      listen: false,
    );

    return GestureDetector(
      onTap: () {
        _moviesModel.setSelectedMovie(widget.movieItem!);
        //  Navigator.of(context).pushNamed(Routes.moviedetail);

        _globalModel.setBottomNavIndex(4);
      },
      child: Container(
        width: 300,
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 6,
                  offset: Offset(2, 3),
                  color: Colors.black.withOpacity(0.06))
            ]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.movieItem!.posterPath != null
                    ? '${APIConfig.image_backdrop_url}${widget.movieItem!.backdropPath}'
                    : Assets.image_not_available,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Center(
                  child: Image.asset(
                    Assets.image_not_available,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //////// Title ..............
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextView(
                      text: widget.movieItem!.title ?? '',
                      fontSize: 22,
                      maxLines: 1,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
            Positioned(
                child: IconButton(
              onPressed: () {
                _moviesModel.addOrRemoveFavouriteList(widget.movieItem!);
              },
              icon: Icon(
                _moviesModel.favouritesMovieIds.contains(widget.movieItem!.id!)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.white,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
