import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/routes.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class ListItemCard extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final int? index;
  const ListItemCard({Key? key, this.imageUrl, this.title, this.index})
      : super(key: key);

  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard> {
  @override
  Widget build(BuildContext context) {
    MoviesViewModel _moviesModel = Provider.of<MoviesViewModel>(
      context,
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.moviedetail);
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
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(2, 3),
                  color: Colors.black.withOpacity(0.1))
            ]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl != null
                    ? '${APIConfig.image_poster_url}${widget.imageUrl}'
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
                _moviesModel.addOrRemoveFavouriteList(widget.index!);
              },
              icon: Icon(
                _moviesModel.favouriteMoviesBoolList[widget.index!]
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
