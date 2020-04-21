import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    // Define the theme, set the primary swatch
    theme: ThemeData(primarySwatch: Colors.grey),
  ));
}

List<String> _cities = ["   Il Seciniz", "Ankara", "Istanbul", "Erzurum","Konya","Zonguldak","Isparta"];
Map<String, List<String>> _counties = {
  "Ankara": ["Etimesgut", "Yenimahalle","Cankaya","Eryaman","Incek","Sincan"],
  "Istanbul": ["Besiktas"]
};

class _SeyahatState extends State<_Seyahat> {
  String _selectedCity, _selectedWhereFrom, _selectedWhereTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(20.0),
      child: Column(
          // Makes the cards stretch in horizontal axis
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Setup the card
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedCity ?? _cities[0],
              isExpanded: true,
              underline: Container(
                height: 40.0,
                decoration: myBoxDecoration(),
              ),
              items: _cities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.home, size: 24.0, color: Colors.orangeAccent),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  _selectedCity = newValue;
                });
              },
            ),
            SizedBox(height: 8.0),
            createCounties(),
            SizedBox(height: 8.0),
            createCounties2(),
            SizedBox(height: 8.0),
            Container(
              height: 40.0,
              decoration: myBoxDecoration(),
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_today,
                      size: 24.0, color: Colors.orangeAccent),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Tarih ve Saat Seciniz",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down,
                      size: 24.0, color: Colors.black54),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 40.0,
              decoration: myBoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.directions_car,
                      size: 24.0, color: Colors.orangeAccent),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Arac Seciniz",
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down,
                        size: 24.0, color: Colors.black54),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text("+",
                    style:
                        TextStyle(color: Colors.orangeAccent, fontSize: 24.0)),
                Text(
                  "     YENI SEFER EKLE",
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            //TextButton(),
            SizedBox(height: 32.0),
            Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _showcontent,
                    color: Colors.orangeAccent,
                    child: Text("UCRETSIZ EKLE",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  DropdownButton<String> createCounties() {
    var currentCounties = ["   Nereden"] + (_counties[_selectedCity] ?? []);
    return DropdownButton<String>(
      value: _selectedWhereFrom ?? currentCounties[0],
      isExpanded: true,
      underline: Container(
        decoration: myBoxDecoration(),
        height: 40.0,
      ),
      items: currentCounties.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(children: <Widget>[
            Icon(Icons.pin_drop, size: 24.0, color: Colors.orangeAccent),
            Text(value),
          ]),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          _selectedWhereFrom = newValue;
        });
      },
    );
  }

  DropdownButton<String> createCounties2() {
    var currentCounties = ["   Nereye"] + (_counties[_selectedCity] ?? []);
    return DropdownButton<String>(
      value: _selectedWhereTo ?? currentCounties[0],
      isExpanded: true,
      underline: Container(
        decoration: myBoxDecoration(),
        height: 40.0,
      ),
      items: currentCounties.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(children: <Widget>[
            Icon(Icons.pin_drop, size: 24.0, color: Colors.orangeAccent),
            Text(value),
          ]),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          _selectedWhereTo = newValue;
        });
      },
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  void _showcontent() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Bilgileriniz'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(
                    "Il: $_selectedCity \nNereden: $_selectedWhereFrom \nNereye: $_selectedWhereTo \nTarih ve Saat:"),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _Seyahat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SeyahatState();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Declare some constants
    final double myTextSize = 16.0;
    final TextStyle myTextStyle =
        TextStyle(color: Colors.black, fontSize: myTextSize);
    return Scaffold(
      appBar: AppBar(
        title: Text("Seyahat Ekle"),
      ),
      body: Container(
        // Sets the padding in the main container
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Column(children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Text(
                        "SEHIR ICI",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),),
                  decoration: myBoxDecoration2(),
                  width: 188.0,
                  height: 48.0,
                ),
                Text("        SEHIRLER ARASI", style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(child: _Seyahat()),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 46.0,
                ),
                Icon(Icons.zoom_in, size: 24.0),
                SizedBox(
                  width: 46.0,
                ),
                Icon(Icons.add, size: 24.0),
                SizedBox(
                  width: 46.0,
                ),
                Icon(Icons.access_alarms, size: 24.0),
                SizedBox(
                  width: 46.0,
                ),
                Icon(Icons.person, size: 24.0),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration2() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.orangeAccent,
        ),
      ),
    );
  }
}
