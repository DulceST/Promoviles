// ignore: file_names
class MoviesDAO{
    int? idMovie;
  String? nameMovie;
  String? overview;
  String? idGenre;
  String? imgMovie;
  String? releaseDate;

  MoviesDAO({this.idMovie, this.nameMovie, this.overview, this.idGenre, this.imgMovie,this.releaseDate});

  factory MoviesDAO.fromMap(Map<String,dynamic> movie){
    return MoviesDAO(idGenre: movie['idGenre'],
    idMovie: movie['idMovie'],
    imgMovie: movie['imgMovie'],
    nameMovie: movie['nameMovie'],
    overview: movie['overview'],
    releaseDate: movie['releaseDate']);
  }
}