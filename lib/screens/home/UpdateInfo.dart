import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http_app/services/Database.dart';
import 'package:http_app/shared/Loading.dart';


class UpdateInfo extends StatefulWidget {
  String name;
  final String email;
  final String uid;
  final String place;
  final int age;
  UpdateInfo({
    this.uid,
    this.name,
    this.email,
    this.place,
    this.age,
  });
  @override
  _UpdateInfoState createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  final CollectionReference personDetails =
      Firestore.instance.collection("Users Info");
  final _key = GlobalKey<FormState>();
  TextEditingController edname = TextEditingController();
  TextEditingController edage = TextEditingController();
  TextEditingController edplace = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/multiback.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(10.0),
              child: Form(
                  key: _key,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Update Profie",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Name";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Name",
                            hintText: widget.name,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                          ),
                          controller: edname,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Age";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Age",
                            hintText: "${widget.age}",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                          ),
                          controller: edage,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Location";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Location",
                            hintText: widget.place,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                          ),
                          controller: edplace,
                        ),
                      ),
                      Container(
                        height: 30.0,
                      ),
                      RaisedButton(
                        color: Colors.white,
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            setState(() async {
                              try {
                                int _age = int.parse(edage.text);
                                await DataBaseService(uid: widget.uid)
                                    .UpdateUserData(widget.email, edname.text,
                                        edplace.text, _age);
                                loading = true;

                                Navigator.pop(context);
                              } catch (e) {
                                print(e);
                              }
                            });
                          } else {
                            loading = false;
                            return "Please Enter All Details";
                          }
                        },
                        child: Text("Update"),
                      ),
                    ],
                  )),
            ),
          );
  }
}
