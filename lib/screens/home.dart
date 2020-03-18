import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class KoronaGo extends StatefulWidget {
  @override
  _KoronaGoState createState() => _KoronaGoState();
}

class _KoronaGoState extends State<KoronaGo> {
  Country _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CountryPicker(
        onChanged: (Country country) {
            setState(() {
              _selected = country;
            });
          },
          selectedCountry: _selected,
      )
    );
  }
}