import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/routes.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class ListItemCard extends StatefulWidget {
  final int? index;
  final Movie? movieItem;
  const ListItemCard({Key? key, this.index, this.movieItem}) : super(key: key);

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard> {
  int cardIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardIndex = widget.index!;
  }

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

        _globalModel.setBottomNavIndex(4);
      },
      child: Container(
        width: 180,
        height: 250,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow,
            boxShadow: [
              BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 4,
                  offset: Offset(2, 3),
                  color: Colors.black.withOpacity(0.1))
            ]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.movieItem?.posterPath != null
                    ? '${APIConfig.image_poster_url}${widget.movieItem!.posterPath}'
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
            Positioned(
                child: IconButton(
              onPressed: () {
                _moviesModel.addOrRemoveFavouriteList(
                    widget.index!, widget.movieItem!);
              },
              icon: Icon(
                _moviesModel.favouriteMoviesBoolList[cardIndex]
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.white,
              ),
            ))
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //         child: TextView(
            //           text: widget.title ?? '',
            //           fontSize: 22,
            //           maxLines: 2,
            //           textColor: Colors.white,
            //         )),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
