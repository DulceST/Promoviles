import 'package:flutter/material.dart';
import 'package:pms2024/screens_P1/product.dart';
import 'package:pms2024/screens_P1/colors.dart';
import 'package:pms2024/screens_P1/product_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PageController pageController;
  double pageOffset = 0;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          builToolbar(),
          buildLogo(size),
          buildPage(size),
        ],
      )),
    );
  }

  Widget builToolbar() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(Icons.location_on),
          Spacer(),
          Icon(Icons.menu),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform(
              transform: Matrix4.identity()
                ..translate(0.0, size.height / 2 * (1 - animation.value))
                ..scale(1 + (1 - animation.value)),
              origin: const Offset(25, 25),
              child: InkWell(
                onTap: () => controller.isCompleted
                    ? controller.reverse()
                    : controller.forward(),
                child: Image.asset(
                  'assets/logoTer.png',
                  width: 50,
                  height: 50,
                ),
              ),
            );
          }),
    );
  }

  Widget buildPage(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(400 * (1 - animation.value), 0),
              child: PageView.builder(
                  controller: pageController,
                  itemCount: getProducts().length,
                  itemBuilder: (context, index) =>
                      Productcard(getProducts()[index], pageOffset, index)),
            );
          }),
    );
  }

  List<Product> getProducts() {
    List<Product> list = [];
    list.add(Product(
        'Persian',
        'Cat',
        'assets/FondoCats.jpg',
        'assets/gatoP.png',
        'Con su elegancia y encanto, han conquistado a todos en la Aldea Sylvanian, trayendo consigo dulzura y mucha calidez.',
        greenLight,
        greenDark));
    list.add(Product(
        'ShibaInu',
        ' Dog',
        'assets/FondoShiba.jpg',
        'assets/perro.png',
        'Llenos de energía y lealtad, han ganado el corazón de los vecinos con sus travesuras y su inigualable espíritu amistoso.',
        yellowLight,
        yellowDark));
    list.add(Product(
        'Penguin',
        'Family',
        'assets/FondoPingui.jpg',
        'assets/pinguino.png',
        'Recién llegados a la Aldea Sylvanian han cautivado el corazón de los vecinos con su amabilidad y, por supuesto, con muchos helados.',
        blueDark,
        blueLight));
    return list;
  }
}
