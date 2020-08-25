import 'package:flutter/material.dart';
import 'package:http_app/screens/home/DetailsList.dart';
import 'package:http_app/services/authcheck.dart';
import 'package:provider/provider.dart';
import 'screens/Wrapper.dart';
import 'screens/home/Aboutpage.dart';
import 'services/authcheck.dart';
import 'package:http_app/Model/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthCheck().user,
        child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.amber,
            accentColor: Colors.amberAccent,
          ),
          debugShowCheckedModeBanner: false,
           routes:<String,WidgetBuilder>{
         // "/ProfilePage":(BuildContext context)=> Profile(),
          "/AboutPage":(BuildContext context)=> AboutPage(),
          "/Search":(BuildContext context)=> DetailsList(),
        },
          home: Scaffold(
//            appBar: AppBar(
//              title: Text("Welcome to My App"),
//            ),
            body: Wrapper(),
          ),
        ));
  }
}
