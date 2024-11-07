
import 'package:flutter/material.dart';
import 'package:pms2024/firebase/database_movie_firebases.dart';
import 'package:pms2024/models/moviesDAO.dart';
import 'package:pms2024/views/movie_view_firebase.dart';
import 'package:pms2024/views/movie_view_item_firebase.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MoviesScreenFirebase extends StatefulWidget {
  const MoviesScreenFirebase({super.key});

  @override
  State<MoviesScreenFirebase> createState() => _MoviesScreenFirebaseState();
}

class _MoviesScreenFirebaseState extends State<MoviesScreenFirebase> {
  late DatabaseMovieFirebases? databaseMovies;
  
  @override
  void initState() {
    super.initState();
    databaseMovies = DatabaseMovieFirebases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies firebase'),
        actions: [
          IconButton(
              onPressed: () {
                WoltModalSheet.show(
                    context: context,
                    pageListBuilder: (context) =>
                        [WoltModalSheetPage(child: MovieViewFirebase())]);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        stream: databaseMovies!.SELECT(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movies = snapshot.data!.docs;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movieData = movies[index];
                return MovieViewItemFirebase(
                    moviesDAO: MoviesDAO.fromMap({
                  'idMovie': 0,
                  'imgMovie': movieData.get('imgMovie'),
                  'nameMovie': movieData.get('nameMovie'),
                  'overview': movieData.get('overview'),
                  'releaseDate': movieData.get('releaseDate').toString(),
                },
                ),
                Uid: movieData.id,
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something was wrong'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
