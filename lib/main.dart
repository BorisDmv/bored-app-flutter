import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Never get bored! 😎🌟';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyApp2(),
      ),
    );
  }
}

class MyApp2 extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp2> {
  String activity = "...";

  @override
  void initState() {
    super.initState();

    RetrieveData();
  }

  RetrieveData() async {
    var url = Uri.https('www.boredapi.com', '/api/activity/', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    final decodedResponse = json.decode(response.body);

    print(decodedResponse["activity"]);
    setState(() {
      activity = decodedResponse["activity"];
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      home: Scaffold(
          body: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            activity,
            style: TextStyle(fontSize: 27.5, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  RetrieveData();
                },
                child: const Text('Still bored?'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailPage()));
                },
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ))),
    );
  }
}
