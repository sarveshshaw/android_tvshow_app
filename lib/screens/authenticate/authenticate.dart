import 'package:flutter/material.dart';
import 'package:http_app/screens/authenticate/Register.dart';
import 'SignIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn= true;
  void toggle(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn==true){
      return SignIn(toggle:toggle);
    }else{
      return Register(toggle:toggle);
    }
  }
}

