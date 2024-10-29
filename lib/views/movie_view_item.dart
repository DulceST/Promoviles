import 'package:flutter/material.dart';
import 'package:pms2024/database/movies_database.dart';
import 'package:pms2024/models/moviesDAO.dart';
import 'package:pms2024/setting/global_values.dart';
import 'package:pms2024/views/movie_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

// ignore: must_be_immutable
class MovieViewItem extends StatefulWidget {
  MovieViewItem(
      {super.key,
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
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(68, 138, 255, 1)),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                'https://i.etsystatic.com/18242346/r/il/933afb/6210006997/il_570xN.6210006997_9fqx.jpg',
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
                          child: MovieView(moviesDAO: widget.moviesDAO,)
                        )
                      ]
                    );
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
          Divider(),
          Text(widget.moviesDAO.overview!),
        ],
      ),
    );
  }
}
