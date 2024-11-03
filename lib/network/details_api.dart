import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailsApi {
  final String apiKey = 'a444da131c5cfb31af43b4c296087406';

  // Método para buscar una película por nombre
  Future<int?> searchMovieByName(String movieName) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(movieName)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        return data['results'][0]['id'];
      } else {
        print('No se encontraron películas con ese nombre.');
        return null;
      }
    } else {
      print('Error al buscar la película: ${response.statusCode}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getMovieTrailer(int movieId) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']?.firstWhere((video) => video['type'] == 'Trailer', orElse: () => null);
    } else {
      print('Error al obtener el tráiler: ${response.statusCode}');
      return null;
    }
  }

//Obtener actores 
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

//Agregar pelicula a favoritos
Future<void> addMovieToFavorites(int movieId, bool isFavorite) async {
  final url = Uri.parse('https://api.themoviedb.org/3/account/{account_id}/favorite?api_key=$apiKey');
  
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'media_type': 'movie',
      'media_id': movieId,
      'favorite': isFavorite, // true para agregar, false para eliminar
    }),
  );

  if (response.statusCode == 200) {
    print(isFavorite ? 'Película agregada a favoritos' : 'Película eliminada de favoritos');
  } else {
    print('Error al agregar/eliminar de favoritos: ${response.statusCode}');
  }
}





}

