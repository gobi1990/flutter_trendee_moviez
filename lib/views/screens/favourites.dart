import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/constants/strings.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/view_models/cast_view_model.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/custom_tab_bar.dart';
import 'package:trendee_moviez/views/widgets/list_item_card.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  GlobalViewModel? _globalModel;
  MoviesViewModel? _moviesModel;
  CastViewModel? _castModel;
  @override
  Widget build(BuildContext context) {
    _globalModel = Provider.of<GlobalViewModel>(context, listen: false);

    _moviesModel = Provider.of<MoviesViewModel>(
      context,
    );

    _castModel = Provider.of<CastViewModel>(
      context,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /////// Title ..................
            Container(
                padding: EdgeInsets.only(
                    //  top: DeviceUtils.getScaledHeight(context, 0.05),
                    bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                child: TextView(
                  text: Strings.favourites,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            Expanded(
              child: CustomTabBar(
                  onChanged: (v) {
                    // _store.changePaymentCategory(v);
                  },
                  pageOneTitle: 'Movies',
                  pageTwoTitle: 'People',
                  pageOne: _buildFavouriteMoviesList('movies'),
                  pageTwo: _buildFavouriteMoviesList('cast')),
            ),

            /////////////////////Favorites movies grid ...................
          ],
        ),
      ),
    );
  }

  Widget _buildFavouriteMoviesList(String type) {
    dynamic favouriteList;
    favouriteList = (type == 'movies')
        ? _moviesModel?.favouritesMovies
        : _castModel?.favouriteCastMembers;
    return Stack(
      children: [
        Container(
            child: GridView.builder(
          padding: EdgeInsets.only(
              top: 20, bottom: DeviceUtils.getScaledHeight(context, 0.02)),
          itemCount: favouriteList.length,
          shrinkWrap: true,
          //  physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 4,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return ListItemCard(
              movieItem: type == 'movies' ? favouriteList[index] : null,
              index: index,
              castMemberItem: type == 'cast' ? favouriteList[index] : null,
            );
          },
        )),
        Visibility(
          visible: favouriteList.isEmpty,
          child: Container(
            padding: EdgeInsets.only(
                top: DeviceUtils.getScaledHeight(context, 0.01)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Center(
                  child: Image.asset(Assets.empty_list),
                )),
                Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DeviceUtils.getScaledWidth(context, 0.2),
                      vertical: DeviceUtils.getScaledHeight(context, 0.02),
                    ),
                    child: TextView(
                      text: type == 'movies'
                          ? Strings.empty_fav_mov_list
                          : Strings.empty_fav_cast_list,
                      textColor: Colors.grey.withOpacity(0.9),
                      maxLines: 3,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
