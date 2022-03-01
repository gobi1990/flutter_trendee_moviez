import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';

class PosterImageCard extends StatelessWidget {
  final String? imageUrl;
  const PosterImageCard({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: DeviceUtils.getScaledHeight(context, 0.02),
          bottom: DeviceUtils.getScaledHeight(context, 0.01)),
      width: DeviceUtils.getScaledWidth(context, 0.6),
      height: DeviceUtils.getScaledHeight(context, 0.45),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 6,
                spreadRadius: 5,
                offset: Offset(2, 4),
                color: Colors.black.withOpacity(0.15))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? Assets.image_not_available,
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
    );
  }
}
