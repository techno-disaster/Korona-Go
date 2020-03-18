import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:koronago/screens/home.dart';

// import 'screens/home.dart';
const String url = "https://thevirustracker.com/free-api?countryTotal=IN";
void main() {
  runApp(MyApp());
}

Future getData() async {
  http.Response response = await http.get(url);

  var data = jsonDecode(response.body);

  print(data["countrydata"]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KoronaGo(),
      // Scaffold(
      //   body: Center(
      //     child: RaisedButton(
      //       onPressed: () {
      //         print("getting korona stats");
      //         getData();
      //       },
      //       child: Container(
      //         color: Colors.red,
      //         height: 100,
      //         width: 100,
      //       ),
      //     ),
      //   ),
      // ),
    );
    // MaterialApp(home: KoronaGo(),
  }
}
