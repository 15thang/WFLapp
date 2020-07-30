import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String username = '';

class NewsLetterPage extends StatefulWidget {
  @override
  _NewsLetterPageState createState() => _NewsLetterPageState();
}

class _NewsLetterPageState extends State<NewsLetterPage> {
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
