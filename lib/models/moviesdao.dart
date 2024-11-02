// ignore: file_names
class MoviesDAO{
    int? idMovie;
    String? idMovief;
  String? nameMovie;
  String? overview;
  String? idGenre;
  String? imgMovie;
  String? releaseDate;

  MoviesDAO({this.idMovie, this.idMovief, this.nameMovie, this.overview, this.idGenre, this.imgMovie,this.releaseDate});

  factory MoviesDAO.fromMap(Map<String,dynamic> movie){
    return MoviesDAO(idGenre: movie['idGenre'],
    idMovie: movie['idMovie'],
    idMovief: movie['idMovief'],
    imgMovie: movie['imgMovie'],
    nameMovie: movie['nameMovie'],
    overview: movie['overview'],
    releaseDate: movie['releaseDate']);
  }
}