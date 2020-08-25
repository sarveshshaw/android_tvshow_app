import'package:flutter/material.dart';
import 'package:http_app/Model/User.dart';
import 'package:http_app/screens/authenticate/authenticate.dart';
import 'package:http_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if ( user== null)
      {
        return Authenticate();
      }else{
      return Home();
    }

  }

}