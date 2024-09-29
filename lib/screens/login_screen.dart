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

    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person)
      ),
    );

    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.password)
      ),
    );

    final ctnCredentials = Positioned(
      bottom: 90,
      child: Container(
        width: MediaQuery.of(context).size.width*.9,
        //margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 247, 243),
          borderRadius: BorderRadius.circular(10)
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            txtUser,
            txtPwd
          ],
        ),
      ),
    );

    final btnLogin = Positioned(
      width: MediaQuery.of(context).size.width * .9,
      bottom: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 200, 238)
        ),
        onPressed: (){
          isLoading = true;
          setState(() {});
          Future.delayed(
            const Duration(milliseconds: 4000)
          ).then((value) => {
            isLoading = false,
            setState(() {}),
            Navigator.pushNamed(context, "/home")
          });
        }, 
        child: const Text('Validar Usuario')
      ),
    );

    final gifLoading = Positioned(
      top: 5,
      child: Image.asset('assets/loading.gif', height: 200,)
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/fondo.jpeg')
          )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Image.asset('assets/logo.png', width: 180,)
            ),
            ctnCredentials,
            btnLogin,
            isLoading ? gifLoading : Container()
          ],
        ),
      ),
    );
  }
}