import 'package:flutter/material.dart';
import 'package:pms2024/database/movies_database.dart';
import 'package:pms2024/models/moviesdao.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  late MoviesDatabase moviesDB; 
  
  @override
  void initState(){
    super.initState();
    moviesDB = MoviesDatabase(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie List'),),
      body:  FutureBuilder(
        future: moviesDB.SELECT(),
        builder: (context, AsyncSnapshot<List<MoviesDAO>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
            itemBuilder: (context,index){
              return MovieViewItem();
            },);
          }else{
            if(snapshot.hasError){
              return Center(child: Text('Somenthing was wrong!'),);
            }else{
              return Center(child: CircularProgressIndicator(),); 
            }
          }
        }
      ),
    );}
    Widget MovieViewItem (){
      return Text('');
    }
  }

 