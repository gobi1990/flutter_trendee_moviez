import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/constants/strings.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/list_item_card.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalViewModel _globalModel =
        Provider.of<GlobalViewModel>(context, listen: false);

    MoviesViewModel _moviesModel = Provider.of<MoviesViewModel>(
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
                  text: Strings.favourites,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            //////////// Search Button.................

///////////////////// Popular movies grid ...................
            Container(
                child: GridView.builder(
              padding: EdgeInsets.only(
                  top: 20, bottom: DeviceUtils.getScaledHeight(context, 0.02)),
              itemCount: _moviesModel.favouritesMovies.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemBuilder: (context, index) {
                return ListItemCard(
                  movieItem: _moviesModel.favouritesMovies[index],
                  index: index,
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
