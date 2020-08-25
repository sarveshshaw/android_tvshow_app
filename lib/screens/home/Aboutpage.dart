import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    launchUrl() async {
      try {
        String url = "https:www.linkedin.com/in/sarvesh-shaw-68a0a9192";
        print(url);
        if (url != null) {
          if (await canLaunch(url)) {
            await launch(url);
            //  print(url);
          }
        }
      } catch (e) {
        print(e);
      }
    }
    return Scaffold(
      
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/darkback.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: 50.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 55.0,
                        backgroundImage: AssetImage("images/devimg.jpeg"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Text(
                  "App Name : One Tap Show",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Text(
                  " Developed By : Sarvesh Shaw",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: new Text(
                  "Using this app users can find details of there favourite tv on one tap and save its details to a database which can be accessed later . ",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: new Text(
                  "Users can also update their profile information at any time . ",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: new RaisedButton(
                  color: Colors.cyan,
                  onPressed: (){
                    launchUrl();
                  },
                child:FlatButton(onPressed: (){
                  launchUrl();
                },
                    child: Text("More Info",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),

                  ),
                ),

            ],
          )),
    );
    // child: ListView(
    //   children: <Widget>[
    //     Card(
    //       child: ListTile(
    //         title: Text("Name "),
    //       ),
    //     ),
    //   ],
    // ),
  }
}
