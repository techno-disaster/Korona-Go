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

  @override
  void initState() {
    super.initState();
    getData("US");
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
                              child: Center(
                                child: Text(
                                  snapshot.data["countrydata"][0]["total_cases"]
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            throw snapshot.error;
                          } else {
                            return Center(child: CircularProgressIndicator());
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
