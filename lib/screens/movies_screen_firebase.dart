
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
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return MovieViewItemFirebase(
                    moviesDAO: MoviesDAO.fromMap({
                  'idMovief': '${snapshot.data!.docs[index].id}',
                  'imgMovie': '${snapshot.data!.docs[index].get('imgMovie')}',
                  'nameMovie': '${snapshot.data!.docs[index].get('nameMovie')}',
                  'overview': '${snapshot.data!.docs[index].get('overview')}',
                  'releaseDate': '${snapshot.data!.docs[index].get('releaseDate')}'
                }));
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
