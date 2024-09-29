/*import 'package:flutter/material.dart';
import 'package:pms2024/database/movies_database.dart';
import 'package:pms2024/models/moviesDAO.dart';
import 'package:pms2024/setting/global_values.dart';


class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  late MoviesDatabase moviesDB;

  @override
  void initState() {
    super.initState();
    moviesDB = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
        actions: [
          IconButton(
            onPressed: (){

              WoltModalSheet.show(
                context: context, 
                pageListBuilder: (context) => [
                  WoltModalSheetPage(
                    child: MovieView()
                  )
                ]
              );

            }, 
            icon: const Icon(Icons.add) 
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.banUpdListMovies,
        builder: (context, value, widget) {
          return FutureBuilder(
            future: moviesDB.SELECT(),
            builder: (context, AsyncSnapshot<List<MoviesDAO>?> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return MovieViewItem(
                      moviesDAO: snapshot.data![index],
                    );
                  },
                );
              }else{
                if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()),);
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              }
            }
          );
        }
      ),
    );
  }  
}*/