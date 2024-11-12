import 'package:flutter/material.dart';
import 'package:pms2024/network/popular_api.dart';
import 'package:pms2024/models/popular_moviedao.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  _FavoriteMoviesScreenState createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  List<PopularMovieDao> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favorites = await PopularApi().getFavoritesList();
    setState(() {
      favoriteMovies = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas Favoritas'),
      ),
      body: favoriteMovies.isEmpty
          ? Center(child: Text('No tienes películas favoritas aún.'))
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return ListTile(
                  leading: Image.network(PopularApi().getMoviePosterUrl(movie.posterPath)),
                  title: Text(movie.title),
                  subtitle: Text('Puntuación: ${movie.voteAverage}'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detailPopular',
                      arguments: movie,
                    );
                  },
                );
              },
            ),
    );
  }
}
