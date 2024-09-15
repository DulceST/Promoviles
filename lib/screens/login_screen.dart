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
    //Campo de texto para usuario
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(prefixIcon: Icon(Icons.person)),
    );
    //Fin campo de texto de usuario

    //Campo de texto de contraseña
    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(prefixIcon: Icon(Icons.password)),
    );
    //Fin campo de texto de contraseña

    //el widget lo cabio con control .
    final ctnCredentials = Positioned(
      //se cambia el widget por positioned y se agrega el width
      bottom: 100,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        //margin: EdgeInsets.symmetric(horizontal: 10),//vcambia en valorres
        decoration: BoxDecoration(
            color: const Color.fromARGB(173, 244, 165, 233),
            borderRadius:
                BorderRadius.circular(20) //para rendondear las esquinas
            ),
        child: ListView(
          shrinkWrap: true,
          children: [
            txtUser,
            txtPwd
          ], //indica que van a estar contenidos varios elementos
        ),
      ),
    );

    //Boton de validacion
    final btnLogin = Positioned(
      width: MediaQuery.of(context).size.width * .9, //estirar el boton
      bottom: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[2]), //color del boton
          onPressed: () {
            isLoading = true;
            setState(() {});
            Future.delayed(const Duration(milliseconds: 4000)).then((value) => {
                  isLoading = false,
                  setState(() {}),
                  Navigator.pushNamed(
                      context, "/home") //navegar a la siguiente pantalla
                });
          },
          child: const Text('Validar Usuario')),
    );
    //Fin del boton de validacion

    final gifLoading = Positioned(
        top: 200,
        child: Image.asset(
          'assets/loading.gif',
          height: 90,
        ));

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/fondoTernurin.jpeg'))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 10,
                child: Image.asset('assets/logoTer.png',width: 200,)
                ),
            ctnCredentials,
            btnLogin,
            isLoading ? gifLoading : Container() //operado terneario
          ],
        ),
      ),
    );
  }
}
