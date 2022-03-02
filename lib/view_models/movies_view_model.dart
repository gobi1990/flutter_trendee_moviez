import 'package:flutter/cupertino.dart';
import 'package:trendee_moviez/models/cast.dart';
import 'package:trendee_moviez/models/cast_member.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/services/cast_api_service.dart';
import 'package:trendee_moviez/services/movies_api_service.dart';

class MoviesViewModel with ChangeNotifier {
  final _movieApiService = MoviesApiService.getInstance();

  List<Movie> _trendingMovies = [];

  List<Movie> _popularMovies = [];

  List<Movie> _searchedMovies = [];

  List<Movie> _favouoritesMovies = [];

  List<int> _favouoritesMovieIds = [];

  List<Cast> _movieCastList = [];

  Movie? _selectedMovie;

  bool _loading = false;

  bool get loading => _loading;

  List<Movie> get trendingMovies => _trendingMovies;

  List<Movie> get popularMovies => _popularMovies;

  List<Movie> get searchMovies => _searchedMovies;

  List<Movie> get favouritesMovies => _favouoritesMovies;

  List<int> get favouritesMovieIds => _favouoritesMovieIds;

  List<Cast> get movieCastList => _movieCastList;

  Movie? get selectedMovie => _selectedMovie;

  MoviesViewModel() {
    getTrendingMovieListFromApi();
    getPopularMoviesListFromApi();
  }

  setSelectedMovie(Movie movie) {
    _selectedMovie = movie;

    int? id = _selectedMovie?.id;

    getAllMovieCastListFromApi(id.toString());
  }

  setLoading(bool value) {
    _loading = value;
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

  setMovieCastList(List<Cast> value) {
    _movieCastList = value;
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
      setSearchedMoviesList(response);
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

  getAllMovieCastListFromApi(String id) async {
    setLoading(true);
    var response = await _movieApiService.getAllMovieCast(id);

    if (response != null) {
      setMovieCastList(response);
    }

    setLoading(false);
  }

  addOrRemoveFavouriteList(Movie? item) {
    int? id = item?.id;

    if (favouritesMovieIds.contains(id)) {
      favouritesMovieIds.remove(id);
      favouritesMovies.remove(item);
    } else {
      favouritesMovieIds.add(id!);
      favouritesMovies.add(item!);
    }

    notifyListeners();
  }
}
