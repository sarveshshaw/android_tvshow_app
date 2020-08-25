import 'package:flutter/material.dart';
import 'package:http_app/services/authcheck.dart';
import 'package:http_app/shared/Loading.dart';
import 'package:http_app/Model/DetailsModel.dart';

class Register extends StatefulWidget {
  final Function toggle;
  Register({this.toggle});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthCheck _auth = AuthCheck();
  final _key = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String pass = '';
  String error = '';
  TextEditingController cage = TextEditingController();

  final det = Details();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Sign Up"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggle();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign In"))
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/multiback.jpeg'),
                fit: BoxFit.cover,
              ),
              ),
              child: Form(
                key: _key,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: <Widget>[
                      Container(height: 100.0,),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Name";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "John Doe",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                    , width: 2.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              det.name = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Place";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Location",
                            hintText: "New Delhi",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,width: 2.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              det.place = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter age";
                            }
                          },
                          controller: cage,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Age",
                            hintText: "20 Years",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Email";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "name@org.ac.in",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onChanged: (value) {
                            setState(() {
                              det.email=value;
                              email = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 10.0,
                      ),
                     
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.length < 8) {
                                return "Password Should be of Atleast 8 Characters";
                              }
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              labelText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                pass = value;
                              });
                            },
                          ),
                        ),
                      
                      Container(
                        height: 20.0,
                      ),
                      RaisedButton(
                          child: Text("Register"),
                          color: Colors.white,
                          onPressed: () async {
                            if (_key.currentState.validate()) {
                              print("valid");
                              setState(() {
                                det.age = int.parse(cage.text);
                                loading = true;
                              });
                              dynamic result = await _auth.register(
                                email,
                                pass,
                                det.name,det.place,det.age
                              );
                              if (result == null)
                                setState(() {
                                  loading = false;
                                  error = "Please enter valid email";
                                });
                            }
                          }),
                      Container(
                        height: 5.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
