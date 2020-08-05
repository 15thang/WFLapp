import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String username = '';

class NewsLetterPage extends StatefulWidget {
  @override
  _NewsLetterPageState createState() => _NewsLetterPageState();
}

class _NewsLetterPageState extends State<NewsLetterPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
  }
  
  TextEditingController emailControl = TextEditingController();
  String get userEmail => emailControl.text;

  insertMethod() async {
    String theUrl = "http://superfighter.nl/APP_insert_newsmail.php";
    var res = await http.post(Uri.encodeFull(theUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "email": userEmail,
    });
    var respBody = json.decode(res.body);
    print(respBody);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Newsletter"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text(
                "Email",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: emailControl,
                decoration: InputDecoration(hintText: '   example@mail.com'),
              ),
              RaisedButton(
                child: Text("Subscribe to WFL-newsletter"),
                color: Colors.blue,
                onPressed: () {
                  _incrementCounter();
                  insertMethod();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
