import 'package:flutter/widgets.dart';
import 'package:trendee_moviez/models/cast_member.dart';
import 'package:trendee_moviez/services/cast_api_service.dart';

class CastViewModel with ChangeNotifier {
  final _castApiService = CastApiService.getInstance();

  List<int> _favouoritesCastMemberIds = [];

  List<CastMember> _favouoritesCastMembers = [];

  bool _loading = false;

  bool get loading => _loading;

  CastMember? _selectedCastMember;

  CastMember? get selectedCastMember => _selectedCastMember;

  List<int> get favouritesCastMemberIds => _favouoritesCastMemberIds;

  List<CastMember> get favouriteCastMembers => _favouoritesCastMembers;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setCastMember(CastMember value) {
    _selectedCastMember = value;
  }

  setEmptyValue() {
    _selectedCastMember = CastMember();
    notifyListeners();
  }

  getCastMemberDetailsFromApi(String id) async {
    setLoading(true);
    var response = await _castApiService.getDetailsOfCastMember(id);

    if (response != null) {
      setCastMember(response);
    }

    setLoading(false);
  }

  addOrRemoveFavouriteCastMemberList(CastMember? castMember) {
    int? id = castMember?.id;

    if (favouritesCastMemberIds.contains(id)) {
      favouritesCastMemberIds.remove(id);
      favouriteCastMembers.remove(castMember);
    } else {
      favouritesCastMemberIds.add(id!);
      favouriteCastMembers.add(castMember!);
    }

    notifyListeners();
  }
}
