import 'package:flutter/cupertino.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/services/movies_api_service.dart';

class MoviesViewModel with ChangeNotifier {
  List<Movie> _trendingMovies = [];

  List<Movie> _popularMovies = [];

  bool _loading = false;
  bool get loading => _loading;
  List<Movie> get trendingMovies => _trendingMovies;

  List<Movie> get popularMovies => _popularMovies;

  MoviesViewModel() {
    getTrendingMovieListFromApi();
    getPopularMoviesListFromApi();
  }

  final _movieApiService = MoviesApiService.getInstance();

  setLoading(bool value) {
    _loading = loading;
    notifyListeners();
  }

  setTrendingMoviesListModel(List<Movie> value) {
    _trendingMovies = value;
  }

  setPopularMoviesListModel(List<Movie> value) {
    _popularMovies = value;
  }

  getTrendingMovieListFromApi() async {
    setLoading(true);
    var response = await _movieApiService.getAllTrendingMoviesList();

    if (response != null) {
      setTrendingMoviesListModel(response);
    }

    setLoading(false);
  }

  getPopularMoviesListFromApi() async {
    setLoading(true);
    var response = await _movieApiService.getAllPopularMoviesList();

    if (response != null) {
      setPopularMoviesListModel(response);
    }

    setLoading(false);
  }
}
