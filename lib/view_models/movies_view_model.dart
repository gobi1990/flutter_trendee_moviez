import 'package:flutter/cupertino.dart';
import 'package:trendee_moviez/models/cast.dart';
import 'package:trendee_moviez/models/cast_member.dart';
import 'package:trendee_moviez/models/movie.dart';
import 'package:trendee_moviez/services/cast_api_service.dart';
import 'package:trendee_moviez/services/movies_api_service.dart';

class MoviesViewModel with ChangeNotifier {
  List<Movie> _trendingMovies = [];

  List<Movie> _popularMovies = [];

  List<Movie> _searchedMovies = [];

  List<Movie> _favouoritesMovies = [];

  List<Cast> _movieCastList = [];

  List<bool> favouriteMoviesBoolList = [];

  CastMember? _selectedCastMember;

  Movie? _selectedMovie;

  bool _loading = false;
  bool get loading => _loading;

  List<Movie> get trendingMovies => _trendingMovies;

  List<Movie> get popularMovies => _popularMovies;

  List<Movie> get searchMovies => _searchedMovies;

  List<Movie> get favouritesMovies => _favouoritesMovies;

  List<Cast> get movieCastList => _movieCastList;

  Movie? get selectedMovie => _selectedMovie;

  CastMember? get selectedCastMember => _selectedCastMember;

  setSelectedMovie(Movie movie) {
    _selectedMovie = movie;

    int? id = _selectedMovie?.id;

    getAllMovieCastListFromApi(id.toString());
  }

  MoviesViewModel() {
    getTrendingMovieListFromApi();
    getPopularMoviesListFromApi();

    //setSearchedMoviesList(popularMovies);
  }

  final _movieApiService = MoviesApiService.getInstance();
  final _castApiService = CastApiService.getInstance();

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

  setMovieCastList(List<Cast> value) {
    _movieCastList = value;
  }

  setCastMember(CastMember value) {
    _selectedCastMember = value;
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

  getAllMovieCastListFromApi(String id) async {
    setLoading(true);
    var response = await _movieApiService.getAllMovieCast(id);

    if (response != null) {
      setMovieCastList(response);
    }

    setLoading(false);
  }

  getCastMemberDetailsFromApi(String id) async {
    setLoading(true);
    var response = await _castApiService.getDetailsOfCastMember(id);

    if (response != null) {
      setCastMember(response);
    }

    setLoading(false);
  }

  addOrRemoveFavouriteList(int index, Movie item) {
    favouriteMoviesBoolList[index] = !favouriteMoviesBoolList[index];

    if (favouritesMovies.contains(item)) {
      favouritesMovies.remove(item);
    } else {
      favouritesMovies.add(item);
    }

    notifyListeners();
  }
}
