//crea la tarjeta con las opciones
import 'package:flutter/material.dart';
import 'package:pms2024/database/movies_database.dart';
import 'package:pms2024/models/moviesDAO.dart';
import 'package:pms2024/screens/details_movie.dart';
import 'package:pms2024/setting/global_values.dart';
import 'package:pms2024/views/movie_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

// ignore: must_be_immutable
class MovieViewItem extends StatefulWidget {
  MovieViewItem({
    super.key,
    required this.moviesDAO,
  });

  MoviesDAO moviesDAO;

  @override
  State<MovieViewItem> createState() => _MovieViewItemState();
}

class _MovieViewItemState extends State<MovieViewItem> {
  MoviesDatabase? moviesDatabase;

  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailsMovie(moviesDAO: widget.moviesDAO),
        ),
        );
      },
      child: Card(
        elevation: 4, // Sombra para dar efecto de tarjeta
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 130,
          decoration:
              BoxDecoration(color: const Color.fromARGB(255, 187, 223, 240)),
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(
                    widget.moviesDAO.imgMovie ??'https://i.etsystatic.com/18242346/r/il/933afb/6210006997/il_570xN.6210006997_9fqx.jpg',
                    height: 100,
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(widget.moviesDAO.nameMovie!),
                      subtitle: Text(widget.moviesDAO.releaseDate!),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        WoltModalSheet.show(
                            context: context,
                            pageListBuilder: (context) => [
                                  WoltModalSheetPage(
                                      child: MovieView(
                                    moviesDAO: widget.moviesDAO,
                                  ))
                                ]);
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        moviesDatabase!
                            .DELETE('tblmovies', widget.moviesDAO.idMovie!)
                            .then((value) {
                          if (value > 0) {
                            GlobalValues.banUpdListMovies.value =
                                !GlobalValues.banUpdListMovies.value;
                            return QuickAlert.show(
                              // ignore: use_build_context_synchronously
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Transaction Completed Successfully!',
                              autoCloseDuration: const Duration(seconds: 2),
                              showConfirmBtn: true,
                            );
                          } else {
                            return QuickAlert.show(
                              // ignore: use_build_context_synchronously
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Something was wrong! :()',
                              autoCloseDuration: const Duration(seconds: 2),
                              showConfirmBtn: false,
                            );
                          }
                        });
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
