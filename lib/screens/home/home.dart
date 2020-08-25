import 'package:flutter/material.dart';
import 'package:http_app/Model/DetailsModel.dart';
import 'package:http_app/Model/User.dart';
import 'package:http_app/shared/drawer.dart';
import 'package:provider/provider.dart';
import 'package:http_app/services/Database.dart';
import 'DetailsList.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final key = GlobalKey<FormState>();
  TextEditingController searchtv = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ;


    return StreamProvider<Details>.value(
      value: DataBaseService(uid: user.uid).userdata,
      child: Scaffold(
        appBar: AppBar(
         // backgroundColor: Colors.cyan,
          title: Text("One Tap Show"),
        ),
        drawer: Drawer(
          child: sideDrawer(),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/darkback.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  Container(height: 100.0),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Search Your Favourite Show ",

                      style:
                      TextStyle(
                         // decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 40.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "On One Tap",

                      style:
                      TextStyle(
                        decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(height: 100,),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0, left: 40),
                    child: TextFormField(
                      controller: searchtv,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter Show Name ";
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white,width: 2.0)),

                        icon: Icon(Icons.search),
                        hintText: "Search Tv-Show",
                        hintStyle: TextStyle(
                          color: Colors.white,

                        ),
                      ),
                    ),
                  ),
                  Container(height: 20.0),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: RaisedButton(
                        onPressed: () async {
                            if(key.currentState.validate()){
                              setState(() {
                                String show=searchtv.text;
                                print(show);
                                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsList(
                     searchshow: show,),
                    ),
                  );
                });
        
              }
       },
                        child: Text("Search",
                        style: TextStyle(
                          color: Colors.black,
                        ),),
                        color: Colors.cyan),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
