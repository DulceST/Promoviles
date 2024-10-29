import 'package:flutter/material.dart';
import 'package:pms2024/models/popular_movie.dart';

class DetailPopularScreen extends StatefulWidget {
  const DetailPopularScreen({super.key});

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  @override
  Widget build(BuildContext context) {
    final popular =
        ModalRoute.of(context)!.settings.arguments as PopularMovieDao;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 3,
            fit: BoxFit.fill,
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
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
                child:Text(popular.title, style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
