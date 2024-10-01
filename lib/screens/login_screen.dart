import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //Obtener tamaño de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, size: screenWidth * 0.06)),
    );

    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password, size: screenWidth * 0.06)),
    );

    final ctnCredentials = Positioned(
      bottom: screenHeight *
          0.2, // Posicionado más arriba o abajo según la pantalla
      child: Container(
        width: screenWidth * 0.9, // Ajusta el ancho al 90% de la pantalla
        padding: EdgeInsets.all(screenWidth * 0.05), // Padding responsive
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 247, 243),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            txtUser,
            SizedBox(height: screenHeight * 0.02), // Espaciado responsive
            txtPwd,
          ],
        ),
      ),
    );

    final btnLogin = Positioned(
      width: screenWidth * 0.9,
      bottom: screenHeight * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 200, 238),
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        ),
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 4000)).then((value) => {
                isLoading = false,
                setState(() {}),
                Navigator.pushNamed(context, "/onboarding")
              });
        },
        child: Text(
          'Validar Usuario',
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
      ),
    );

    final gifLoading = Positioned(
        top: screenHeight * 0.35,
        child: Image.asset(
          'assets/loading.gif',
          height:  screenHeight * 0.1,
        ));

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/fondo.jpeg'))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: screenHeight * 0.1,
                child: Image.asset(
                  'assets/logo.png',
                  width: screenWidth * 0.5,
                )),
            ctnCredentials,
            btnLogin,
            isLoading ? gifLoading : Container()
          ],
        ),
      ),
    );
  }
}
