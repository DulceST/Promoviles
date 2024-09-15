import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:pms2024/screens_P1/colors.dart';
import 'package:pms2024/screens_P1/formas.dart';
import 'package:pms2024/screens_P1/product.dart';

// ignore: must_be_immutable
class Productcard extends StatelessWidget {
  Product product;
  double pageOffset;
  late double animation;
  double animate = 0;
  double rotate = 0;
  double columnAnimation = 0;
  int index;

  Productcard(this.product, this.pageOffset, this.index);

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
          Text(
            product.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: product.lightColor),
          ),
          Text(
            product.conName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: product.darkColor),
          )
        ],
      ),
    );
  }

  buildBackgroundImage(double cardWidth, double cardHeight, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeight,
      bottom: size.height * .15,
      child: ClipPath(
        clipper: MyClipPath(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            product.backgroundImage,
            fit: BoxFit.cover,
            height: cardHeight,
            width: cardWidth,
          ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            const Text(
              'Lucas Persian',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.description,
              style: const TextStyle(
                  color: Color.fromARGB(179, 15, 14, 14), fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),

            //Inciio Widget para mostrar la calificacion
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color.fromARGB(255, 236, 245, 63),
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            //Fin Widget para mostrar la calificacion

          //Inicio Widget tooltip pata informacion adicional
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
                child: Icon(Icons.info_outline,
                color: Colors.white,
                ),
              ),
            ),
            ),
          //Fin  Widget tooltip pata informacion adicional
          
             const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  color: greenDark, borderRadius: BorderRadius.circular(20)),
              child: const Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '\$',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '4.',
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                    Text(
                      '70',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProImage(Size size) {
    return Positioned(
      bottom: -10,
      right: -30,
      child: Image.asset(
        product.produImage,
        height: size.height * .45,
      ),
    );
  }
}
