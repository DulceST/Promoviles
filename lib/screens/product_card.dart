import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:pms2024/screens/colors.dart';
import 'package:pms2024/screens/product.dart';

// ignore: must_be_immutable
class Productcard extends StatelessWidget {
  Product product;
  double pageOffset;
  late double animation;
  double animate = 0;
  double rotate = 0;
  double columnAnimation = 0;
  int index;

  Productcard(this.product, this.pageOffset, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardWidth = size.width - 60;
    double cardHeight = size.height * .55;
    double count = 0;
    double page;
    for (page = pageOffset; page > 1;) {
      page--;
      count++;
    }
    animation = Curves.easeOutBack.transform(page);
    animate = 100 * (count + animation);
    columnAnimation = 50 * (count + animation);
    for (int i = 0; i < index; i++) {
      animate -= 100;
      columnAnimation -= 50;
    }

    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          builTopText(),
          buildBackgroundImage(cardWidth, cardHeight, size),
          buildAdoveCard(cardWidth, cardHeight, size),
          buildProImage(size),
        ],
      ),
    );
  }

  Widget builTopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          Expanded(
          child: Text(
            product.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: product.lightColor),
          ),
          ),
          Expanded(
            child: Text(
            product.conName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: product.darkColor),
          ),
          ),
        ],
      ),
    );
  }

  buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth * 0.80,
      height: cardHeight,
      bottom: size.height * .15,
      left: size.width * 0.080, // Centramos la imagen ajustada
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            product.backgroundImage,
            fit: BoxFit.cover,
            height: cardHeight,
            width: cardWidth,
          ),
        ),
      );
  }

 Widget buildAdoveCard(double cardWidth, double cardHeight, Size size) {
  return Positioned(
    width: cardWidth,
    height: cardHeight,
    bottom: size.height * .15,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: product.darkColor.withOpacity(.50),
          borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.all(10),

      // Envolvemos el contenido en un SingleChildScrollView para evitar desbordamiento
      child: SingleChildScrollView( // Esto permite que se desplace si es necesario
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.name,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.description,
              style: const TextStyle(
                  color: Color.fromARGB(249, 6, 6, 6), fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),

            //Inciio Widget para mostrar la calificación
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color.fromARGB(255, 236, 245, 63),
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(
              height: 10,
            ),

            //Inicio Widget tooltip para información adicional
            JustTheTooltip(
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Este es un producto popular con varias características únicas. ¡Descubre más sobre él!',
                  style: TextStyle(color: Color.fromARGB(255, 12, 12, 12)),
                ),
              ),
              child: Material(
                color: Colors.green.shade100,
                shape: const CircleBorder(),
                elevation: 4.0,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            // Contenedor de precio
            Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                  color: greenDark, borderRadius: BorderRadius.circular(20)),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '\$',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '4.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      '70',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

//Imagen del produti
  Widget buildProImage(Size size) {
    return Positioned(
      bottom: 10, // Ajuste la posición inferior para que quede sobre la tarjeta
      right: -10, // Mueve la imagen un poco a la derecha para que no tape el contenido
      child: Image.asset(
        product.produImage,
        height: size.height * .40, // Ajusta la imagen del producto
         fit: BoxFit.contain, //  se encarga de que la imagen se ajuste sin distorsionarse
      ),
    );
  }
}