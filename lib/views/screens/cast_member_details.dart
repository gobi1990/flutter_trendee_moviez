import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/constants/assets.dart';
import 'package:trendee_moviez/models/cast.dart';
import 'package:trendee_moviez/models/cast_member.dart';
import 'package:trendee_moviez/utils/deviceutils.dart';
import 'package:trendee_moviez/view_models/cast_view_model.dart';
import 'package:trendee_moviez/view_models/global_view_model.dart';
import 'package:trendee_moviez/view_models/movies_view_model.dart';
import 'package:trendee_moviez/views/widgets/poster_image_card.dart';
import 'package:trendee_moviez/views/widgets/text_view.dart';

class CastMemberDetailsScreen extends StatefulWidget {
  CastMemberDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CastMemberDetailsScreen> createState() =>
      _CastMemberDetailsScreenState();
}

class _CastMemberDetailsScreenState extends State<CastMemberDetailsScreen> {
  CastViewModel? _castViewModel;
  GlobalViewModel? _globalModel;
  CastMember? _selectedCast;

  @override
  Widget build(BuildContext context) {
    _castViewModel = Provider.of<CastViewModel>(
      context,
    );

    _globalModel = Provider.of<GlobalViewModel>(
      context,
    );

    _selectedCast = _castViewModel?.selectedCastMember;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.dstATop),
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(
                    '${APIConfig.image_profile_url}${_selectedCast?.profilePath}',
                    errorListener: () {},
                  )
                  //  NetworkImage(
                  // '${APIConfig.image_profile_url}${_selectedCast?.profilePath}')
                  ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            onPressed: () {
                              _globalModel?.setBottomNavIndex(
                                  _globalModel?.getCurrentNavIndex() != 0
                                      ? _globalModel!.getCurrentNavIndex()
                                      : 0);
                              ////////// Assigning empty object & clear previous data.......
                              _castViewModel?.setCastMember(CastMember());
                            },
                            icon: Icon(
                              Icons.chevron_left_rounded,
                              size: 35,
                            ),
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            onPressed: () {
                              _castViewModel!
                                  .addOrRemoveFavouriteCastMemberList(
                                      _selectedCast);
                            },
                            icon: Icon(
                              _castViewModel!.favouritesCastMemberIds
                                      .contains(_selectedCast?.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 30,
                            ),
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  PosterImageCard(
                    imageUrl: _selectedCast != null
                        ? (_selectedCast?.profilePath != null
                            ? '${APIConfig.image_profile_url}${_selectedCast?.profilePath}'
                            : Assets.image_not_available)
                        : Assets.image_not_available,
                    heightScale: 0.5,
                  ),
                  /////// Title ..................
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextView(
                        text: _selectedCast?.name ?? '',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        maxLines: 2,
                        textColor: Colors.blueGrey,
                      )),

                  Container(
                    width: DeviceUtils.getScaledWidth(context, 1),
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      direction: Axis.horizontal,
                      children: [
                        _buildExtraDetails(
                            'Date Of Birth', _selectedCast?.birthday),
                        _buildExtraDetails('Place Of Birth',
                            _selectedCast?.placeOfBirth ?? ''),
                      ],
                    ),
                  ),

                  /////// Overview ..................
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: TextView(
                        text: _selectedCast?.biography ?? '',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.justify,
                        textColor: Colors.blueGrey,
                      )),
                ],
              ),
            ),
          ),
          Visibility(
              visible: _castViewModel!.loading,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.15),
                child: Center(
                    child: SpinKitFadingCircle(
                  color: Colors.black,
                )),
              ))
        ],
      ),
    ));
  }

  Widget _buildExtraDetails(String? title, String? subtitle) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.4),
      child: Column(
        children: [
          /////// Title ..................
          Container(
              padding: EdgeInsets.only(
                  top: DeviceUtils.getScaledHeight(context, 0.02),
                  bottom: DeviceUtils.getScaledHeight(context, 0.01)),
              child: TextView(
                text: title ?? '',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )), /////// SubTitle ..................
          Container(
              child: TextView(
            text: subtitle ?? '',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            textColor: Colors.blueGrey,
          )),
        ],
      ),
    );
  }
}
