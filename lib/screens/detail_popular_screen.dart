import 'package:flutter/material.dart';
import 'package:pms2024/models/popular_moviedao.dart';
import 'package:pms2024/network/popular_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPopularScreen extends StatefulWidget {
  const DetailPopularScreen({super.key});

  @override
  _DetailPopularScreenState createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  late PopularMovieDao movie;
  YoutubePlayerController? _youtubePlayerController;
  String? _trailerUrl;
  List<dynamic>? _cast;
  bool isFavorite = false;

   @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        movie = ModalRoute.of(context)!.settings.arguments as PopularMovieDao;
      });
      checkIfFavorite();
    });
  }

  Future<void> checkIfFavorite() async {
    final result = await PopularApi().isInList(movie.id);
    setState(() {
      isFavorite = result;
    });
  }

   void toggleFavorite() async {
    if (isFavorite) {
      await PopularApi().removeFromList(movie.id);
    } else {
      await PopularApi().addToList(movie.id);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _youtubePlayerController?.dispose(); // Limpiar el controlador de YouTube
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movie = ModalRoute.of(context)?.settings.arguments as PopularMovieDao;

    PopularApi().getMovieTrailer(movie.id).then((trailer) {
      if (trailer != null) {
        setState(() {
          _trailerUrl = trailer['key'];
          _youtubePlayerController = YoutubePlayerController(
            initialVideoId: _trailerUrl!,
            flags: YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        });
      }
    });

    // Obtener el cast (elenco) de la película
    PopularApi().getMovieCast(movie.id).then((cast) {
      setState(() {
        _cast = cast;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final popularApi = PopularApi();
    final posterUrl = popularApi.getMoviePosterUrl(movie.posterPath);
    return Scaffold(
      appBar: AppBar(
        actions: [
           IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo que ocupa toda la pantalla
          Image.network(
            posterUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.black.withOpacity(
                  0.6), // Fondo oscuro para mejorar la visibilidad del texto
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  // Si hay URL del tráiler, mostrar el reproductor de YouTube
                  _trailerUrl != null
                      ? YoutubePlayer(
                          controller: _youtubePlayerController!,
                          showVideoProgressIndicator: true,
                        )
                      : CircularProgressIndicator(),
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  // Mostrar la puntuación de los usuarios
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 28),
                      SizedBox(width: 5),
                      Text(
                        '${movie.voteAverage}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _cast != null && _cast!.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cast:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Lista horizontal de actores
                            Container(
                              height:
                                  150, // Altura del contenedor para los actores
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _cast!.length,
                                itemBuilder: (context, index) {
                                  final actor = _cast![index];
                                  final actorName = actor['name'];
                                  final actorImage = actor['profile_path'];
                                  final actorImageUrl =
                                      'https://image.tmdb.org/t/p/w500$actorImage';

                                  return Container(
                                    width: 100,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      children: [
                                        ClipOval(
                                          child: actorImage != null
                                              ? Image.network(
                                                  actorImageUrl,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  'https://via.placeholder.com/80',
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          actorName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
