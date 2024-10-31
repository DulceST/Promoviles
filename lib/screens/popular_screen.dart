import 'package:flutter/material.dart';
import 'package:pms2024/models/popular_moviedao.dart';
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

  Widget cardPopular(PopularMovieDao popular) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: popular),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${popular.posterPath}?? ''}',
                  ),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: .7,
                child: Container(
                  color: Colors.black,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Text(popular.title, style: const TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}