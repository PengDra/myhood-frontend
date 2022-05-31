import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:myhood/src/register/register_controller.dart';
import 'package:myhood/src/utils/my_colors.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _textRegister(),
              _imageUser(),
              const SizedBox(height: 20),
              _textFieldEmail(),
              const SizedBox(height: 20),
              _textFieldName(),
              const SizedBox(height: 20),
              _textFieldLastName(),
              const SizedBox(height: 20),
              _textFieldRut(),
              const SizedBox(height: 20),
              _textFieldPhone(),
              const SizedBox(height: 20),
              _textFieldPassword(),
              const SizedBox(height: 20),
              _textFieldConfirmPassword(),
              const SizedBox(height: 20),
              _buttonRegister(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textRegister() {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
        const Text(
          'REGISTRO',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _imageUser() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/images/user_profile_2.png'),
      radius: 50,
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: _con.emailController,
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

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Nombre',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.person, color: MyColors.primary),
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.lastNameController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Apellido',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.person_outline, color: MyColors.primary),
        ),
      ),
    );
  }

  Widget _textFieldRut() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.rutController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'RUT',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.person, color: MyColors.primary),
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: _con.phoneController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Telefono',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.phone, color: MyColors.primary),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
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

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacity,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyColors.black),
          hintText: 'Confirmar Password',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.lock_outline, color: MyColors.primary),
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
          onPressed: _con.register,
          child: Text('Registrarse'),
          style: ElevatedButton.styleFrom(
              primary: MyColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 15))),
    );
  }
}
