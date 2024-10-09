import 'package:flutter/material.dart';
import 'package:pms2024/models/popular_movie.dart';
import 'package:pms2024/network/popular_api.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  
  PopularApi? popularApi;

  @override
  void initState() {
    super.initState();
    popularApi = PopularApi();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: popularApi!.getPopularMovies(), 
        builder: (context, AsyncSnapshot<List<PopularMovieDao>> snapshot) {
          if( snapshot.hasData ){
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ), 
              itemBuilder: (context, index) {
                return Image.network('https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}');
              },
            );
          }else{
            if( snapshot.hasError ){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }
}