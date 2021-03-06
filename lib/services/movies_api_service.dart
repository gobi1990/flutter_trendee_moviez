import 'package:dio/dio.dart';
import 'package:trendee_moviez/config/api_config.dart';
import 'package:trendee_moviez/models/cast.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/models/popular_movies_list_response.dart';
import 'package:trendee_moviez/services/http_service.dart';

class MoviesApiService {
  static MoviesApiService _moviesApiService = MoviesApiService._();

  MoviesApiService._();

  static MoviesApiService getInstance() => _moviesApiService;

  HttpService? _httpService = HttpService();

  //////////////// Get All Popular Movies list ...................
  Future<List<Movie>?> getAllPopularMoviesList() async {
    Response? popularMoviesListResponse;

    popularMoviesListResponse =
        await _httpService!.getRequest(APIConfig.popular_movies);

    List<Movie> _moviesList = [];
    _moviesList =
        Movie.listFromJson(popularMoviesListResponse!.data['results']);

    return _moviesList;
  }

  //////////////// Get All Trending Movies list ...................
  Future<List<Movie>?> getAllTrendingMoviesList() async {
    Response? moviesListResponse;

    moviesListResponse =
        await _httpService!.getRequest(APIConfig.trending_movies);

    List<Movie> _moviesList = [];
    _moviesList = Movie.listFromJson(moviesListResponse!.data['results']);

    return _moviesList;
  }

  //////////////// Get Searched Movies list ...................
  Future<List<Movie>?> getSearchedMoviesList(String query) async {
    Response? moviesListResponse;

    moviesListResponse =
        await _httpService!.getRequest(APIConfig.search_movies, query: query);

    List<Movie> _moviesList = [];
    _moviesList = Movie.listFromJson(moviesListResponse!.data['results']);

    return _moviesList;
  }

  //////////////// Get All movie cast list ...................
  Future<List<Cast>?> getAllMovieCast(String id) async {
    Response? castListResponse;

    castListResponse = await _httpService!.getRequest(
      APIConfig.getMovieCastUrl(id),
    );

    List<Cast> _castList = [];
    _castList = Cast.listFromJson(castListResponse!.data['cast']);

    return _castList;
  }
}
