import 'package:flutter/material.dart';
import 'package:myhood/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          child: Column(
            children: [
              _imageBanner(),
              _textFieldEmail(),
              _textFieldPassword(),
              _buttonLogin(),
              _textDontHaveAccount()
            ],
          )),
    );
  }

  Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.22, bottom: MediaQuery.of(context).size.height * 0.22),
      child: Image.asset(
        'assets/img/iconomyhood300x300.png',
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacity,
        borderRadius: BorderRadius.circular(30)
      ),
      child:  TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Email',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.email, color: MyColors.primary),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacity,
        borderRadius: BorderRadius.circular(30)
      ),
      child:  TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Password',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.lock, color: MyColors.primary),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Iniciar sesión'),
        style: ElevatedButton.styleFrom(
          primary: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 15)

        )
          
        ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('¿No tienes una cuenta?',
            style: TextStyle(
              color: MyColors.primary,
            )),
        SizedBox(
          width: 10,
        ),
        Text('Registrate',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.purple,
            )),
      ],
    );
  }
}
