import 'package:flutter/material.dart';
import 'package:http_app/shared/Loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Detail_tile.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class DetailsList extends StatefulWidget {
  String searchshow;

  DetailsList({this.searchshow});

  @override
  _DetailsListState createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  bool loading;
  bool fetchstatus = false;
  String burl = "http://api.tvmaze.com/search/shows?q=";
  List data;
  List genre;
  bool status;
  String showname;
  int showid;
  int items;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
    loading = true;
  }

  Future<String> getJsonData() async {
    var response = await http.get(Uri.encodeFull("$burl${widget.searchshow}"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      loading = false;
      fetchstatus = true;
    } else {
      loading = false;
    }

    setState(() {
      var cjdata = json.decode(response.body);
      data = cjdata;
      items = data.length;
    });

    return "sucess";
  }

  @override
  Widget build(BuildContext context) {
    ShowAlert(BuildContext context) {
      Widget okbutton = FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "OK",
          style: TextStyle(color: Colors.amber),
        ),
      );

      AlertDialog alert = AlertDialog(
        title: Text("Alert"),
        content: Text("No More Information Available"),
        actions: [
          okbutton,
        ],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }

    return loading
        ? Loading()
        : Scaffold(
            appBar:
                AppBar(title: Text("Search Results For ${widget.searchshow}")),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/darkback.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: ListView.builder(
                    itemCount: data == null ? 0 : items,
                    itemBuilder: (BuildContext context, int index) {
                      genre = data[index]['show']['genres'];
                      Text getlang() {
                        try {
                          return Text(
                            data[index]['show']['language'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } catch (e) {
                          return Text(
                            "English",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }

                      Text getchannel() {
                        try {
                          return Text(
                            data[index]['show']['network']['name'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } catch (e) {
                          return Text(
                            "ABC",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }

                      Text getcountry() {
                        try {
                          return Text(
                            data[index]['show']['network']['country']['name'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } catch (e) {
                          return Text(
                            "United States",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }

                      Text getgenre1() {
                        try {
                          return Text(
                            data[index]['show']['genres'][0],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } catch (e) {
                          return Text(
                            "Drama",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }

                      Text getgenre2() {
                        try {
                          return Text(
                            " , ${data[index]['show']['genres'][1]}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } catch (e) {
                          return Text(
                            ".",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }

                      Image showimg() {
                        try {
                          return Image.network(
                              '${data[index]['show']['image']['original']}');
                        } catch (e) {
                          print(e);
                          return Image(
                              image: AssetImage('images/appicon.jpeg'));
                        }
                      }

                      Text getname() {
                        return Text(
                          data[index]['show']['name'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }

                      Text getrating() {
                        try {
                          if (data[index]['show']['rating']['average'] ==
                              null) {
                            return Text(
                              "Rating: 6.8",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return Text(
                              "Rating: ${data[index]['show']['rating']['average']} ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                      }

                      launchUrl() async {
                        try {
                          String url = "${data[index]['show']['officialSite']}";
                          print(url);
                          if (url != null) {
                            if (await canLaunch(url)) {
                              await launch(url);
                              //  print(url);
                            }
                          }
                          if (url == "null") {
                            //alert
                            ShowAlert(context);
                          }
                        } catch (e) {
                          print(e);
                        }
                      }

                      ShowTile() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detailtile(
                                showid: data[index]['show']['id'],
                              ),
                            ));
                      }

                      return fetchstatus
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Container(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Card(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(child: showimg()),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: getname(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: getrating(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: Row(
                                                      children: <Widget>[
                                                        getgenre1(),
                                                        Expanded(child: getgenre2()),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: getlang(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: getchannel(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: getcountry(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: RaisedButton(
                                                      color: Colors.amberAccent,
                                                      elevation: 5,
                                                      child: Text("More"),
                                                      onPressed: () {
                                                        launchUrl();
                                                        // ShowTile();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              child: Center(
                                child: Text("No Result Found"),
                              ),
                            );
                    }),
              ),
            ),
          );
  }
}
