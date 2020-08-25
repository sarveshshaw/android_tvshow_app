import 'package:flutter/material.dart';


class Detailtile extends StatefulWidget {
 int showid;

Detailtile({this.showid });

  @override
  _DetailtileState createState() => _DetailtileState();
}

class _DetailtileState extends State<Detailtile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Text("${widget.showid}"),
      ),
    );
  }
}