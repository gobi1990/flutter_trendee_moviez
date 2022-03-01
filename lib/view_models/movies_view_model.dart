import 'package:flutter/cupertino.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/services/movies_api_service.dart';

class MoviesViewModel with ChangeNotifier {
  List<Movie> _trendingMovies = [];

  List<Movie> _popularMovies = [];

  List<Movie> _searchedMovies = [];

  List<Movie> _favouoritesMovies = [];

  List<bool> favouriteMoviesBoolList = [];

  bool _loading = false;
  bool get loading => _loading;

  List<Movie> get trendingMovies => _trendingMovies;

  List<Movie> get popularMovies => _popularMovies;

  List<Movie> get searchMovies => _searchedMovies;

  List<Movie> get favouritesMovies => _favouoritesMovies;

  Movie? _selectedMovie;

  Movie? get selectedMovie => _selectedMovie;

  setSelectedMovie(Movie movie) {
    _selectedMovie = movie;
  }

  MoviesViewModel() {
    getTrendingMovieListFromApi();
    getPopularMoviesListFromApi();
  }

  final _movieApiService = MoviesApiService.getInstance();

  setLoading(bool value) {
    _loading = loading;
    notifyListeners();
  }

  setTrendingMoviesList(List<Movie> value) {
    _trendingMovies = value;
  }

  setPopularMoviesList(List<Movie> value) {
    _popularMovies = value;
  }

  setSearchedMoviesList(List<Movie> value) {
    _searchedMovies = value;
  }

  setFavouritesMoviesList(List<Movie> value) {
    _favouoritesMovies = value;
  }

  getTrendingMovieListFromApi() async {
    setLoading(true);
    var response = await _movieApiService.getAllTrendingMoviesList();

    if (response != null) {
      setTrendingMoviesList(response);
    }

    setLoading(false);
  }

  getPopularMoviesListFromApi() async {
    setLoading(true);
    var response = await _movieApiService.getAllPopularMoviesList();

    if (response != null) {
      setPopularMoviesList(response);

      for (var item in response) {
        favouriteMoviesBoolList.add(false);
      }
    }

    setLoading(false);
  }

  getSearchedMoviesListFromApi(String query) async {
    setLoading(true);
    var response = await _movieApiService.getSearchedMoviesList(query);

    if (response != null) {
      setSearchedMoviesList(response);
    }

    setLoading(false);
  }

  addOrRemoveFavouriteList(int index) {
    favouriteMoviesBoolList[index] = !favouriteMoviesBoolList[index];
    notifyListeners();
  }
}
