// import 'dart:math';

class FeaturedMovieModel {
  final String original_title, overview, poster_path, country, release_date;
  final int id, run_time;
  final double rating;
  final List genre;
  FeaturedMovieModel(
      {required this.country,
      required this.rating,
      required this.genre,
      required this.release_date,
      required this.run_time,
      required this.original_title,
      required this.overview,
      required this.poster_path,
      required this.id});
  factory FeaturedMovieModel.fromJson(Map<String, dynamic> json) {
    return FeaturedMovieModel(
      original_title: json['original_title'],
      overview: json['overview'],
      poster_path: json['poster_path'],
      id: json['id'],
      release_date: json['release_date'],
      // run_time: json['runtime'],
      // genre: json['genres'],
      rating: json['vote_average'],
      country: '',
      genre: [],
      run_time: 0,
    );
  }
}
