class PopularMovieDao {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
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
        backdropPath: popular['backdrop_path'],
        id: popular['id'],
        originalLanguage: popular['originalLanguage'],
        originalTitle: popular['originalTitle'],
        overview: popular['overview'],
        popularity: popular['popularity'],
        posterPath: popular['posterPath'],
        releaseDate: popular['releaseDate'],
        title: popular['title'],
        voteAverage: popular['voteAverage'],
        voteCount: popular['voteCount)']);
  }
}
