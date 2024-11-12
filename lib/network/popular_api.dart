import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pms2024/models/popular_moviedao.dart';
import 'package:http/http.dart' as http;

class PopularApi {
  final dio = Dio();
  final String apiKey = 'a444da131c5cfb31af43b4c296087406';

  Future<List<PopularMovieDao>> getPopularMovies() async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1');
    final res = response.data["results"] as List;
    return res.map((popular) => PopularMovieDao.fromMap(popular)).toList();
  }

  // Método para obtener los detalles de la película directamente por ID
  Future<Map<String, dynamic>?> getMovieDetails(String movieId) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=en-US');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Devuelve los detalles de la película
    } else {
      print(
          'Error al obtener los detalles de la película: ${response.statusCode}');
      return null;
    }
  }

  // Método para obtener el tráiler de la película por ID
  Future<Map<String, dynamic>?> getMovieTrailer(int movieId) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']?.firstWhere((video) => video['type'] == 'Trailer',
          orElse: () => null);
    } else {
      print('Error al obtener el tráiler: ${response.statusCode}');
      return null;
    }
  }

  // Método para obtener el elenco (actores) de la película por ID
  Future<List<dynamic>?> getMovieCast(int movieId) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=en-US');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['cast']; // Devuelve la lista de actores
    } else {
      print('Error al obtener los actores: ${response.statusCode}');
      return null;
    }
  }

  // Método para obtener la URL de la imagen del poster de la película
  String getMoviePosterUrl(String posterPath) {
    if (posterPath.isEmpty) {
      return 'https://via.placeholder.com/500x750?text=No+Image'; // Imagen por defecto
    }
    return 'https://image.tmdb.org/t/p/w500$posterPath'; // URL de la imagen del poster
  }

  Future<void> addToList(int movieId) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/list/8496229/add_item?api_key=$apiKey&session_id=df9ad4a2da1915b4df28ea66036d8f4618adc236');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'media_id': movieId,
      }),
    );

    if (response.statusCode == 201) {
      print('Película agregada a la lista correctamente');
    } else {
      print('Error al agregar la película a la lista: ${response.statusCode}');
    }
  }
  Future<void> removeFromList(int movieId) async {
  final url = Uri.parse(
    'https://api.themoviedb.org/3/list/8496229/remove_item?api_key=$apiKey&session_id=df9ad4a2da1915b4df28ea66036d8f4618adc236',
  );

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "media_id": movieId,
    }),
  );

  if (response.statusCode == 200) {
    print("Película eliminada de favoritos exitosamente");
  } else {
    print("Error al eliminar de favoritos: ${response.statusCode}");
  }
}


  Future<bool> isInList(int movieId) async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/list/8496229?api_key=$apiKey&language=en-US');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final movies = data['items'] as List<dynamic>;
    return movies.any((movie) => movie['id'] == movieId);
  } else {
    print('Error al verificar la lista: ${response.statusCode}');
    return false;
  }
}
Future<List<PopularMovieDao>> getFavoritesList() async {
  final url = Uri.parse(
    'https://api.themoviedb.org/3/list/8496229?api_key=$apiKey&language=es-MX',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final results = data['items'] as List;
    return results.map((item) => PopularMovieDao.fromMap(item)).toList();
  } else {
    print('Error al obtener la lista de favoritos: ${response.statusCode}');
    return [];
  }
}

}
