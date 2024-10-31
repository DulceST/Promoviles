import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pms2024/firebase/database_movie_firebases.dart';
import 'package:pms2024/models/moviesDAO.dart';
import 'package:pms2024/setting/global_values.dart';
import 'package:quickalert/quickalert.dart';

// ignore: must_be_immutable
class MovieViewFirebase extends StatefulWidget {
  MovieViewFirebase({super.key, this.moviesDAO});

  MoviesDAO? moviesDAO;

  @override
  State<MovieViewFirebase> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieViewFirebase> {
  TextEditingController conName = TextEditingController();
  TextEditingController conOverview = TextEditingController();
  TextEditingController conImgMovie = TextEditingController();
  TextEditingController conRelease = TextEditingController();

  DatabaseMovieFirebases? moviesDatabase;


  @override
  void initState() {
    super.initState();
    moviesDatabase = DatabaseMovieFirebases();
    if (widget.moviesDAO != null) {
      conName.text = widget.moviesDAO!.nameMovie!;
      conOverview.text = widget.moviesDAO!.overview!;
      conImgMovie.text = widget.moviesDAO!.imgMovie!;
      conRelease.text = widget.moviesDAO!.releaseDate!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameMovie = TextFormField(
      controller: conName,
      decoration: const InputDecoration(
        hintText: 'Nombre de la película',
      ),
    );
    final txtOverview = TextFormField(
      controller: conOverview,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Sinopsis',
      ),
    );
    final txtImgMovie = TextFormField(
      controller: conImgMovie,
      decoration: const InputDecoration(
        hintText: 'Poster de la película',
      ),
    );
    final txtRelease = TextFormField(
      readOnly: true,
      controller: conRelease,
      decoration: const InputDecoration(
        hintText: 'Fecha de lanzamiento',
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
        );
        if (pickedDate != null) {
          String formatDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          conRelease.text = formatDate;
          setState(() {});
        } else {}
      },
    );

    final btnSave = ElevatedButton(
      onPressed: () {
        if (widget.moviesDAO == null) {
          moviesDatabase!.INSERT(
            {
              'nameMovie': conName.text,
              'overview': conOverview.text,
              'imgMovie': conImgMovie.text,
              'releaseDate': conRelease.text
            },
          ).then((value) {
            if (value) {
              GlobalValues.banUpdListMovies.value =
                  !GlobalValues.banUpdListMovies.value;
              return QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Transaction completed successfully!',
                  autoCloseDuration: const Duration(seconds: 3),
                  showConfirmBtn: false);
            } else {
              return QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  text: 'Something was wrong',
                  autoCloseDuration: const Duration(seconds: 3),
                  showConfirmBtn: false);
            }
          });
        } /*else {
          moviesDatabase!.UPDATE(
            {
              "idMovie": widget.moviesDAO!.idMovie,
              'nameMovie': conName.text,
              'overview': conOverview.text,
              'imgMovie': conImgMovie.text,
              'releaseDate': conRelease.text
            },
          ).then((value) {
            final String msj;
            QuickAlertType type = QuickAlertType.success;
            if (value) {
              GlobalValues.banUpdListMovies.value = !GlobalValues.banUpdListMovies.value;
              type = QuickAlertType.success;
              msj = 'Transaction completed Successfully!';
            } else {
              type = QuickAlertType.error;
              msj = 'Something was wrong!';
            }
            return QuickAlert.show(
              context: context,
              type: type,
              text: msj,
              autoCloseDuration: const Duration(seconds: 3),
              showConfirmBtn: false,
            );
          });
        }*/
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[200],
      ),
      child: const Text('Guardar'),
    );

    return ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        txtNameMovie,
        txtOverview,
        txtImgMovie,
        txtRelease,
        btnSave,
      ],
    );
  }
}