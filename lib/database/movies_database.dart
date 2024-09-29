import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pms2024/models/moviesDAO.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabase {
  static const NAMEDB = 'MOVIESDB';
  static const VERSIONDB = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await initDatabase();
  }

  Future<Database> initDatabase() async {
    Directory folder =
        await getApplicationDocumentsDirectory(); //CON ESTE METODO ACCCEDEMOS A DIRECTORIOS SEGUROS
    String path = join(folder.path, NAMEDB);
    return openDatabase(path, version: VERSIONDB, onCreate: (db, version) {
      //PARA CUANDO SEA LA PRIMERA VEZ QUE SE INSTALA LA APP EJECUTE ESTE METODO
      //DENTRO ESTE METODO PODEMOS EJECUTAR LOS QUERYS QUE QUERAMOS
      String query1 = '''
          CREATE TABLE tblgenre(
            idGenre char(1) PRIMARY KEY,
            dscgenre VARCHAR(50)
          );''';

          db.execute(query1);
      String query2 = '''
          CREATE TABLE tblmovies(
            idmovie INTEGER PRIMARY KEY ,
            nameMovie varchar(100),
            overview text(),
            idGenero char(1),
            imgMovie VARCGAR(150),
            releaseDate CHAR(10), 
            constraint fk_genre foreign key(idGenero) references tblgenre(idGenre);
        );''';
      db.execute(query2);
    },
    );
  } //initdatabase

//estos seran metodos que se ejecuten en ssegundo plano
  Future<int> INSERT(String table, Map<String, dynamic> row) async {
    //dynamic utiliza para regresar cualquier tipo de dato
    var con = await database;
    return await con.insert(table, row);
  }

  Future<int> UPDATE(String table, Map<String, dynamic> row) async {
    var con = await database;
    return await con.update(table, row, where: 'idMovie = ?', whereArgs: [
      row['idMovie'],
    ]);
  }

  Future<int> DELETE(String table, int idMovie) async {
    var con = await database; //para ver si existe la conexion
    return await con.delete(table, where: 'idMovie = ?', whereArgs: [idMovie]);
  }

  Future<List<MoviesDAO>> SELECT() async {
    var con = await database;
    var result = await con.query('tblmovies');
    return result.map((movie) => MoviesDAO.fromMap(movie)).toList();
  }
}
