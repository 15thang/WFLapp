import 'package:flutter/material.dart';
import '../model/competitiesStats.dart';

class Competities extends StatelessWidget {
  static String routeName;


@override 
Widget build(BuildContext context) {
  final List<Widget> widgets = List(competities.length);
  for (var i = 0; i < competities.length; i++) {
    widgets[i] = GestureDetector(
      onTap: () {
        Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {}
                //builder: (context) => CompetitiesDetailPage(event: null,),
              ),
            );
            print("Container clicked " + i.toString());
      },
    child: Container(
            child: Column(
              children: <Widget>[
                Card(
                  color: Colors.blueGrey[50],
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(10),
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                competities[i].title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: 170,
                                  child: Text(
                                    competities[i].description,
                                    style: TextStyle(
                                      fontSize: 16,
                                    )
                                    )),
                              Container(
                                padding: const EdgeInsets.only(top: 31, left: 38),  
                                  child: Text(
                                    'Lees Meer >',
                                  style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                    )),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
    }
    return Container(    
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: widgets.toList(),
        ));
  }
}