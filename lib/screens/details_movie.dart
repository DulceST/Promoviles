import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pms2024/models/moviesDAO.dart';
import 'package:pms2024/network/details_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsMovie extends StatefulWidget {
  const DetailsMovie({super.key, required this.moviesDAO});
  final MoviesDAO moviesDAO;

  @override
  State<DetailsMovie> createState() => _DetailsMovieState();
}

class _DetailsMovieState extends State<DetailsMovie> {
  final DetailsApi detailsApi = DetailsApi();
  String? trailerUrl;
  late YoutubePlayerController _youtubePlayerController;
  List<dynamic>? castData;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    fetchTrailerUrlByName(widget.moviesDAO.nameMovie!);
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  void toggleFavorite(int movieId) async {
    setState(() {
      isFavorite = !isFavorite; // Cambia el estado a lo contrario
    });

    await detailsApi.addMovieToFavorites(
        movieId, isFavorite); // Llama al método para agregar o eliminar
    if (isFavorite) {
      print('Película agregada a favoritos');
    } else {
      print('Película eliminada de favoritos');
    }
  }

  Future<void> fetchTrailerUrlByName(String movieName) async {
    final movieId = await detailsApi.searchMovieByName(movieName);
    if (movieId != null) {
      final trailerData = await detailsApi.getMovieTrailer(movieId);
      if (trailerData != null && trailerData['key'] != null) {
        setState(() {
          trailerUrl = trailerData['key'];
          _youtubePlayerController = YoutubePlayerController(
            initialVideoId: trailerUrl!,
            flags: YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        });
        fetchMovieCast(movieId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se encontró el tráiler.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se encontró la película.')),
      );
    }
  }

  Future<void> fetchMovieCast(int movieId) async {
    final castResponse = await detailsApi.getMovieCast(
        movieId); // Asegúrate de tener el método para obtener los actores
    setState(() {
      castData = castResponse; // Almacena la lista de actores
    });
  }

  Widget buildCastList(List<dynamic> cast) {
    return Container(
      height: 100, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, index) {
          final actor = cast[index];
          return Container(
            width: 80, // Ancho de cada tarjeta
            child: Column(
              children: [
                actor['profile_path'] != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${actor['profile_path']}',
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 80,
                        color: Colors.grey,
                        child: Icon(Icons.person, size: 40),
                      ),
                Text(actor['name'],
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Película'),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              final movieId = widget.moviesDAO.idMovie; // Obtén el ID de la película
              if (movieId != null) { // Asegúrate de que movieId no sea null
                toggleFavorite(movieId); // Llama a la función para alternar favoritos
              } else {
                print('No se encontró el ID de la película para agregar a favoritos');
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              widget.moviesDAO.imgMovie ??
                  'https://i.etsystatic.com/18242346/r/il/933afb/6210006997/il_570xN.6210006997_9fqx.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (trailerUrl != null)
                  YoutubePlayer(
                    controller: _youtubePlayerController,
                    showVideoProgressIndicator: true,
                  )
                else
                  CircularProgressIndicator(),
                SizedBox(height: 16), // Espacio entre el título y los detalles
                Text(
                  '${widget.moviesDAO.nameMovie}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Fecha de lanzamiento: ${widget.moviesDAO.releaseDate}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Descripción: ${widget.moviesDAO.overview}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                if (castData != null &&
                    castData!
                        .isNotEmpty) // Asegúrate de que la lista de actores no esté vacía
                  Container(height: 200, child: buildCastList(castData!))
                else
                  CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
