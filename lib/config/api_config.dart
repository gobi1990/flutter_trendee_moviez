class APIConfig {
  //////////////////////// TMDB API key...................
  static String api_key = $TMDB_API_KEY;

  ///////////////////// Base Url ........ Movies DB.................
  static String base_url = "https://api.themoviedb.org/3/";

  ////////////////// Image Base Url...............
  static String image_base_url = "https://image.tmdb.org/t/p/";

  ////////////////// Image Backdrop size...............
  static String image_backdrop_url = "https://image.tmdb.org/t/p/w300";

  ////////////////// Image Poster size...............
  static String image_poster_url = "https://image.tmdb.org/t/p/w500";

  ////////////////// Image Profile size...............
  static String image_profile_url = "https://image.tmdb.org/t/p/w185";

  ////////////// Popular movies....................
  static String popular_movies = "movie/popular";

  ////////////// Upcoming movies....................
  static String upcoming_movies = "movie/popular";

  ////////////// Trending movies....................
  static String trending_movies = "trending/movie/week";

  ////////////// Search Movies....................
  static String search_movies = "search/movie";

  //////////// Get Movie Cast .....................
  static String getMovieCastUrl(String id) {
    return 'movie/' + id + '/credits';
  }

  //////////// Get Cast Member details .....................
  static String getCastMemberDetailsUrl(String id) {
    return 'person/' + id;
  }
}
