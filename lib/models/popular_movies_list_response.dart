import 'package:trendee_moviez/models/movie.dart';

class PopularMoviesListResponse {
  int? page;
  List<Movie>? movies;
  int? totalPages;
  int? totalResults;

  PopularMoviesListResponse(
      {this.page, this.movies, this.totalPages, this.totalResults});

  PopularMoviesListResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movies = Movie.listFromJson(json['results']);
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.movies != null) {
      data['results'] = this.movies!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }

  static List<PopularMoviesListResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? <PopularMoviesListResponse>[]
        : json
            .map((value) => new PopularMoviesListResponse.fromJson(value))
            .toList();
  }
}
