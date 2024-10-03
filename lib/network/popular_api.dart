import 'package:dio/dio.dart';
class PopularApi {
  final dio= Dio(); 
  void getPopularMovies() async{
final response = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1');
final res = response.data;  
  }
}