import 'package:flutter/material.dart';
import 'package:http_app/Model/DetailsModel.dart';
import 'package:http_app/screens/home/MyProfile.dart';
import 'package:http_app/screens/home/UpdateInfo.dart';
import 'package:http_app/services/authcheck.dart';
import 'package:provider/provider.dart';

class sideDrawer extends StatelessWidget {
  final AuthCheck _auth = AuthCheck();
  @override
  Widget build(BuildContext context) {
    final udet = Provider.of<Details>(context) ;
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(udet.name),
          accountEmail: Text(udet.email),
          currentAccountPicture: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        Container(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: ListTile(
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(
                      uid: udet.uid,
                      name: udet.name,
                      email: udet.email,
                      place: udet.place,
                      age: udet.age,
                    ),
                  )
                  );
            },
            leading: Icon(Icons.account_box),
            title: Text("My Profile"),
          ),
        ),
 
   
        Padding(
          padding: EdgeInsets.all(6.0),
          child: ListTile(
            onTap: () async {
              Navigator.pop(context);
               Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateInfo(
                        uid: udet.uid,
                      name: udet.name,
                      email: udet.email,
                      place: udet.place,
                      age: udet.age,
                      ),
                    ));
            },
            leading: Icon(Icons.edit),
            title: Text("Update Profile "),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: ListTile(
            onTap: () async {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/AboutPage");
            },
            leading: Icon(Icons.info_outline),
            title: Text("About "),
          ),
        ),
        
         Container(height:355.0),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: ListTile(
            onTap: () async {
              await _auth.SignOut();
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          ),
        ),
      ],
    );
  }
}
