class PopularMovieDao {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;

  PopularMovieDao({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PopularMovieDao.fromMap(Map<String, dynamic> popular) {
    return PopularMovieDao(
      backdropPath: popular['backdrop_path'] ?? '',
      id: popular['id'] ?? 0,
      originalLanguage: popular['original_language'] ?? 'unknown',
      originalTitle: popular['original_title'] ?? 'Untitled',
      overview: popular['overview'] ?? 'No overview available',
      popularity: (popular['popularity'] ?? 0.0).toDouble(),
      posterPath: popular['poster_path'] ?? '',
      releaseDate: popular['release_date'] ?? 'Unknown release date',
      title: popular['title'] ?? 'Untitled',
      voteAverage: (popular['vote_average'] ?? 0.0).toDouble(),
      voteCount: popular['vote_count'] ?? 0,
    );
  }
}