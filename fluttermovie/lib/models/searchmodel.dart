class SearchModel {
  final String original_title, title, poster_path, release_date;
  final int id, vote_count;

  SearchModel({
    required this.vote_count,
    required this.release_date,
    required this.original_title,
    required this.title,
    required this.poster_path,
    required this.id,
  });
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        original_title: json['original_title'],
        title: json['title'],
        poster_path: json['poster_path'],
        id: json['id'],
        release_date: json['release_date'],
        vote_count: json['vote_count']);
  }
}
