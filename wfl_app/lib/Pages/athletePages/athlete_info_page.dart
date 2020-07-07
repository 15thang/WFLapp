import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wfl_app/model/athletes.dart';

class AthletesInfoPage extends StatelessWidget {
  // Declare a field that holds the Athlete.
  final Athlete athlete;

  // In the constructor, require a Athlete.
  AthletesInfoPage({Key key, @required this.athlete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: ListView.builder(
        itemBuilder: (context, index) {
          String athleteWeightclass = athlete.athleteWeightclass;
          switch (athleteWeightclass) {
            case "0":
              athleteWeightclass = "";
              break;
            case "1":
              athleteWeightclass = "95+";
              break;
            case "2":
              athleteWeightclass = "95";
              break;
            case "3":
              athleteWeightclass = "84";
              break;
            case "4":
              athleteWeightclass = "77";
              break;
            case "5":
              athleteWeightclass = "70";
              break;
            case "6":
              athleteWeightclass = "65";
              break;
            case "7":
              athleteWeightclass = "61";
              break;
            case "8":
              athleteWeightclass = "56";
              break;
            case "9":
              athleteWeightclass = "52";
              break;
            case "10":
              athleteWeightclass = "48";
              break;
            case "11":
              athleteWeightclass = "44";
              break;
            case "12":
              athleteWeightclass = "40";
              break;
            case "13":
              athleteWeightclass = "36";
              break;
            case "14":
              athleteWeightclass = "32";
              break;
          }
          //switch case om de nummers naar letters te veranderen
          String athleteGrade = athlete.athleteGrade;
          switch (athleteGrade) {
            case "0":
              athleteGrade = "";
              break;
            case "1":
              athleteGrade = "A";
              break;
            case "2":
              athleteGrade = "B";
              break;
            case "3":
              athleteGrade = "C";
              break;
            case "4":
              athleteGrade = "N";
              break;
            case "5":
              athleteGrade = "J";
              break;
          }
          //Als ster 1 is, wordt het een ster
          String athleteStar = athlete.athleteStar.toString();
          if (athleteStar == "1") {
            athleteStar = "★";
          }
          return new GestureDetector(
            child: new Card(
              color: Colors.grey[900],
              elevation: 5,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey[900],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                  image: new NetworkImage(
                                      athlete.athleteProfilePicture),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: <Widget>[
                                  Text(athleteStar,
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.yellow[700],
                                        shadows: <Shadow>[
                                          Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 3.0,
                                              color: Colors.black),
                                        ],
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5.0),
                                    child: Text(athlete.athleteStars,
                                        style: TextStyle(fontSize: 17)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                athlete.athleteTitle,
                                style: TextStyle(
                                    color: Colors.yellow,
                                    backgroundColor: Colors.red[900]),
                              ),
                              Text(athlete.athleteFullName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(athlete.athleteNationality,
                                  style: TextStyle(color: Colors.white)),
                              Text(athlete.athleteDayOfBirth,
                                  style: TextStyle(color: Colors.white)),
                              Text(athleteWeightclass + '" ' + athleteGrade,
                                  style: TextStyle(color: Colors.white)),
                              Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                child: Text(athlete.athleteDescription,
                                    style: TextStyle(color: Colors.white)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 10.0, bottom: 5.0),
                                child: Text('STATS',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 1000,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  width: 1,
                                                ),
                                                bottom: BorderSide(
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: Text('WINS',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                          Container(
                                            width: 1000,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[600],
                                              border: Border(
                                                right: BorderSide(
                                                  width: 1,
                                                ),
                                                bottom: BorderSide(
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                                athlete.athleteWins.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 22)),
                                          ),
                                          Container(
                                            width: 1000,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  width: 1,
                                                ),
                                                bottom: BorderSide(
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: Text('TKO',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                          Container(
                                            width: 1000,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[600],
                                              border: Border(
                                                right: BorderSide(
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                                athlete.athleteTKO.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 1000,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  width: 1,
                                                ),
                                                bottom: BorderSide(
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: Text('LOSSES',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                          Container(
                                            width: 1000,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[600],
                                              border: Border(
                                                left: BorderSide(
                                                  width: 1,
                                                ),
                                                bottom: BorderSide(
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                                athlete.athleteLosses
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 22)),
                                          ),
                                          Container(
                                            width: 1000,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  width: 1,
                                                ),
                                                bottom: BorderSide(
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: Text('KO',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                          Container(
                                            width: 1000,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[600],
                                              border: Border(
                                                left: BorderSide(
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                                athlete.athleteKO.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1000,
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      width: 2,
                                    ),
                                    right: BorderSide(
                                      width: 2,
                                    ),
                                    bottom: BorderSide(
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Text('DRAW',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Container(
                                width: 1000,
                                decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  border: Border(
                                    left: BorderSide(
                                      width: 2,
                                    ),
                                    right: BorderSide(
                                      width: 2,
                                    ),
                                    bottom: BorderSide(
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Text(athlete.athleteDraws.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 1,
      ),
    );
  }
}
