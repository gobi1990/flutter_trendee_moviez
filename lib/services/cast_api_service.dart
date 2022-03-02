import 'package:dio/dio.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/models/cast.dart';
import 'package:trendee_moviez/models/cast_member.dart';
import 'package:trendee_moviez/services/http_service.dart';

class CastApiService {
  static CastApiService _castApiService = CastApiService._();

  CastApiService._();

  static CastApiService getInstance() => _castApiService;

  HttpService? _httpService = HttpService();

  //////////////// Get All details of a specific cast member ...................
  Future<CastMember?> getDetailsOfCastMember(String id) async {
    Response? castDetailsResponse;

    castDetailsResponse = await _httpService!.getRequest(
      APIConfig.getCastMemberDetailsUrl(id),
    );

    CastMember? _cast;
    _cast = CastMember.fromJson(castDetailsResponse!.data);

    return _cast;
  }
}
