import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class BackDropCard extends StatefulWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  BackDropCard({Key? key, this.title, this.description, this.imageUrl})
      : super(key: key);

  @override
  State<BackDropCard> createState() => _BackDropCardState();
}

class _BackDropCardState extends State<BackDropCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                spreadRadius: 2,
                offset: Offset(2, 3),
                color: Colors.black.withOpacity(0.25))
          ]),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl != null
                  ? '${APIConfig.image_backdrop_url}${widget.imageUrl}'
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
                    text: widget.title ?? '',
                    fontSize: 25,
                    maxLines: 2,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white,
                  )),
            ],
          ),
          Positioned(
              child: IconButton(
            onPressed: () {
              
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ))
        ],
      ),
    );
  }
}
