import 'package:flutter/material.dart';
import 'package:http_app/services/authcheck.dart';
import 'package:http_app/shared/Loading.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn({this.toggle});

  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  final AuthCheck _auth = AuthCheck();
  bool loading =false;
  String email='';
  String pass='';
  String error='';

  final _key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Sign In"),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggle();}, icon: Icon(Icons.person), label: Text("Register"))
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
                Container(height:200.0),
                Padding(padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return "Please Enter Email";
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white,width: 2.0)),
                      labelText: "Email",
                      hintText: "name@email.com",
                     // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onChanged: (value){
                        setState(() {
                          email= value;
                        });
                    },
                  ),
                ),
                Container(height: 10.0,),
                Padding(padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value){
                      if(value.length < 8){
                        return "Password Should be of Atleast 8 Characters";
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white,width: 2.0)),
                      labelText: "Password",
                    //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    obscureText: true,
                    onChanged: (value){
                      setState(() {
                        pass= value;
                      });
                    },
                  ),
                ),
                Container(height: 20.0,),
                RaisedButton(
                  child: Text("Sign In"),
                  color: Colors.white,
                  onPressed: () async {
                       if (_key.currentState.validate()){
                         print("valid");
                         setState(() {
                           loading=true;
                         });

                         dynamic result = await _auth.checkSign(email, pass);
                         if(result==null)
                           setState(() {
                             loading=false;
                             error="Invalid Email or Password";
                           });
                       }
                  }
                ),
                Container(height: 5.0,),
                Text(error,
                  style: TextStyle(color:Colors.red),
                  textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
