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
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return cardPopular(snapshot.data![index]);
              },
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  //funcion que retorna un widget
  Widget cardPopular(PopularMovieDao popular) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'detail', arguments: popular),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  //le vamos a poner un borde redondeado
                  image: DecorationImage(
                      fit: BoxFit
                          .fill, //para que abarque mas el tamanio del espacio de las tarjetas
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),),),
            ),),);
  }
}
