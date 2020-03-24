import 'package:flutter/material.dart';

import 'package:koronago/screens/home.dart';

// import 'screens/home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KoronaGo(),
    );
    // MaterialApp(home: KoronaGo(),
  }
}
