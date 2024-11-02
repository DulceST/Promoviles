import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailsApi {
  final String apiKey = 'a444da131c5cfb31af43b4c296087406';

  Future<Map<String, dynamic>?> getMovieTrailer(int movieId) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']?.firstWhere((video) => video['type'] == 'Trailer');
    } else {
      print('Error fetching trailer: ${response.statusCode}');
      return null;
    }
  }
}
