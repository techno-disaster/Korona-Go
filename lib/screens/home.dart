import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_country_picker/flutter_country_picker.dart';

class KoronaGo extends StatefulWidget {
  @override
  _KoronaGoState createState() => _KoronaGoState();
}

class _KoronaGoState extends State<KoronaGo> {
  Country selected;
  Future getData(iso) async {
    var url = 'https://thevirustracker.com/free-api?countryTotal=$iso';
    http.Response response = await http.get(url);

    var data = jsonDecode(response.body);

    print(data["countrydata"]);
    return data;
  }

  Future gettimelineData(iso) async {
    var url = 'https://thevirustracker.com/free-api?countryTimeline=$iso';
    http.Response timelineresponse = await http.get(url);

    var timelinedata = jsonDecode(timelineresponse.body);

    // TODO garph logic
    return timelinedata;
  }

  @override
  void initState() {
    super.initState();
    getData("US");
    gettimelineData("US");
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
        actions: <Widget>[
          CountryPicker(
            showName: false,
            showDialingCode: false,
            onChanged: (Country country) {
              setState(() {
                selected = country;
                getData(selected.isoCode);
                gettimelineData(selected.isoCode);
              });
            },
            selectedCountry: selected,
          ),
        ],
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: FutureBuilder(
                        future:
                            getData(selected == null ? "US" : selected.isoCode),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 100, 11),
                                    child: Text(
                                      snapshot.data["countrydata"][0]["info"]
                                              ["title"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data["countrydata"][0]
                                              ["total_cases"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.87),
                                          fontSize: 25),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }
                        },
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
                    margin: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: FutureBuilder(
                        future:
                            getData(selected == null ? "US" : selected.isoCode),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 100, 11),
                                    child: Text(
                                      snapshot.data["countrydata"][0]["info"]
                                              ["title"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(
                                        "+" +
                                            snapshot.data["countrydata"][0]
                                                    ["total_new_cases_today"]
                                                .toString(),
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: 25),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    child: Text(
                                      "New Cases Today",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            throw snapshot.error;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }
                        },
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
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: FutureBuilder(
                        future:
                            getData(selected == null ? "US" : selected.isoCode),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 100, 11),
                                    child: Text(
                                      snapshot.data["countrydata"][0]["info"]
                                              ["title"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data["countrydata"][0]
                                              ["total_deaths"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 25),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }
                        },
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: FutureBuilder(
                        future:
                            getData(selected == null ? "US" : selected.isoCode),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 100, 11),
                                    child: Text(
                                      snapshot.data["countrydata"][0]["info"]
                                              ["title"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(
                                        "+" +
                                            snapshot.data["countrydata"][0]
                                                    ["total_new_deaths_today"]
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 25),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    child: Text(
                                      "Deaths Today",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            throw snapshot.error;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }
                        },
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
                      child: FutureBuilder(
                        future:
                            getData(selected == null ? "US" : selected.isoCode),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 100, 11),
                                    child: Text(
                                      snapshot.data["countrydata"][0]["info"]
                                              ["title"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      snapshot.data["countrydata"][0]
                                              ["total_recovered"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 25),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }
                        },
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
                    margin: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                    color: Color.fromRGBO(18, 18, 18, 1),
                    child: Container(
                      child: FutureBuilder(
                        future:
                            getData(selected == null ? "US" : selected.isoCode),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 100, 11),
                                    child: Text(
                                      snapshot.data["countrydata"][0]["info"]
                                              ["title"]
                                          .toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(
                                        snapshot.data["countrydata"][0]
                                                ["total_serious_cases"]
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(24, 119, 242, 1),
                                            fontSize: 25),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    child: Text(
                                      "Serious Cases",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            throw snapshot.error;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            );
                          }
                        },
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
            ],
          ),
        ],
      ),
    );
  }
}
