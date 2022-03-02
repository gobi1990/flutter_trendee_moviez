import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/constants/strings.dart';
import 'package:trendee_moviez/routes.dart';
import 'package:trendee_moviez/services/movies_api_service.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/back_drop_card.dart';
import 'package:trendee_moviez/views/widgets/list_item_card.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalViewModel _globalModel =
        Provider.of<GlobalViewModel>(context, listen: false);

    MoviesViewModel _moviesModel = Provider.of<MoviesViewModel>(
      context,
    );
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /////// Title ..................
                Container(
                    padding: EdgeInsets.only(
                        //top: DeviceUtils.getScaledHeight(context, 0.05),
                        bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                    child: TextView(
                      text: Strings.app_name,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                //////////// Search Button.................
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        child: TextView(
                          text: Strings.trending,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: () {
                              _globalModel.setBottomNavIndex(3);
                            },
                            icon: Icon(Icons.search)))
                  ],
                ),
                ////////////// Tredning Movies List ...............

                SizedBox(
                  height: 220,
                  child: Stack(
                    children: [
                      ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _moviesModel.trendingMovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            return BackDropCard(
                              movieItem: _moviesModel.trendingMovies[index],
                            );
                          }),
                      Visibility(
                        child: Center(
                          child: SpinKitFadingCircle(
                            color: Colors.black,
                          ),
                        ),
                        visible: _moviesModel.loading,
                      )
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: 15,
                        ),
                        child: TextView(
                          text: Strings.popular,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
///////////////////// Popular movies grid ...................
                Container(
                    child: GridView.builder(
                  padding: EdgeInsets.only(
                      top: 20,
                      bottom: DeviceUtils.getScaledHeight(context, 0.02)),
                  itemCount: _moviesModel.popularMovies.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 4,
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return ListItemCard(
                      movieItem: _moviesModel.popularMovies[index],
                      index: index,
                    );
                  },
                ))
              ],
            ),
          ),
        ));
  }
}
