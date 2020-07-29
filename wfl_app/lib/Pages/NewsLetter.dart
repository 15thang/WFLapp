import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String username = '';

class NewsLetterPage extends StatefulWidget {
  @override
  _NewsLetterPageState createState() => _NewsLetterPageState();
}

class _NewsLetterPageState extends State<NewsLetterPage> {
  TextEditingController email = new TextEditingController();

  Future<List> senddata() async {
    final response =
        await http.post("http://superfighter.nl/APP_insert_newsmail.php", body: {
      "email": email.text,
    });
    var datauser = json.decode(response.body);
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
                controller: email,
                decoration: InputDecoration(hintText: '   example@mail.com'),
              ),
              SizedBox(
                height: 75,
              ),
              RaisedButton(
                child: Text("Subscribe to WFL-newsletter"),
                color: Colors.blue,
                onPressed: () {
                  senddata;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
