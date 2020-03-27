
// Screen isn;t used yet idk 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KoronaGlobal extends StatefulWidget {
  @override
  _KoronaGlobalState createState() => _KoronaGlobalState();
}

class _KoronaGlobalState extends State<KoronaGlobal> {
  Future getGlobalData() async {
    var url = 'https://thevirustracker.com/free-api?global=stats';
    http.Response response = await http.get(url);

    var data = jsonDecode(response.body);

    print(data["results"][0]);
    return data;
  }

  @override
  void initState() {
    super.initState();
    getGlobalData();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenwidth = queryData.size.width;
    double screenheight = queryData.size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 18, 18, 0.8),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 18, 18, 0.8),
        elevation: 0,
        title: Text("CovidMate"),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(22, 15, 0, 8),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(22, 15, 13, 15),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FutureBuilder(
                            future: getGlobalData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          "Global",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              snapshot.data["results"][0]
                                                      ["total_serious_cases"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight / 220,
                                          ),
                                          Container(
                                            child: Text(
                                              "Serious Cases",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                throw snapshot.error;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      width: screenwidth / 1.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(15, 15, 7.5, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: getGlobalData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              snapshot.data["results"][0]
                                                      ["total_cases"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight / 220,
                                          ),
                                          Container(
                                            child: Text(
                                              "Infected",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    throw snapshot.error;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      height: screenheight / 8,
                      width: screenwidth / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(7.5, 15, 15, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: getGlobalData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              snapshot.data["results"][0]
                                                      ["total_new_cases_today"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight / 220,
                                          ),
                                          Container(
                                            child: Text(
                                              "New Cases Today",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    throw snapshot.error;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      height: screenheight / 8,
                      width: screenwidth / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(15, 15, 7.5, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: getGlobalData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              snapshot.data["results"][0]
                                                      ["total_deaths"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight / 220,
                                          ),
                                          Container(
                                            child: Text(
                                              "Deaths",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    throw snapshot.error;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      height: screenheight / 8,
                      width: screenwidth / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(7.5, 15, 15, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: getGlobalData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "+" +
                                                  snapshot.data["results"][0][
                                                          "total_new_deaths_today"]
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight / 220,
                                          ),
                                          Container(
                                            child: Text(
                                              "Deaths Today",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    throw snapshot.error;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      height: screenheight / 8,
                      width: screenwidth / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 13, 0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: ListView(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                future: getGlobalData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              snapshot.data["results"][0]
                                                      ["total_recovered"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 25),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight / 220,
                                          ),
                                          Container(
                                            child: Text(
                                              "Recovered",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.5),
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    throw snapshot.error;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      height: screenheight / 8,
                      width: screenwidth / 1.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
