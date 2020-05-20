import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

const URL = "https://www.eventbrite.nl/o/world-fighting-league-28797683507";

class HomePage extends StatelessWidget {

  Future launchURL(String url) async {
    if (await canLaunch(url)){
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      print("Can't Launch");
    }
  }

  @override
  Widget build(BuildContext context) {

    /*final List<Widget> widgets = List(upcommingEventList.length);
    for (var i = 0; i < 4; i++) {
      widgets[i] = GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailPage(event: upcommingEventList[i]),
              ),
            );
            print("Container clicked " + i.toString());
          },
              child: Container(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                    bottom: 10,
                    top: 0,
                    ),
                    child: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[  
                      Card(
                        elevation: 10,
                        child: Container(  
                          height: 180,
                          width: 200,
                          decoration: BoxDecoration(  
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(  
                              fit: BoxFit.cover,
                              image: NetworkImage(eventList[i+1].imageUrl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
    }*/
    

    
    return
    Container( 
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: <Widget>[
            //items
            Column( 
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              ],
              ),
          ),
          //event column
          GestureDetector(
            onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) {}
               // builder: (context) => EventDetailPage(event: topEvent[0]),
              ),
            );
            print("Container clicked " + 0.toString());
          },
              child: Container(  
              height: 350,
              width: double.infinity,
                child: Container(
                    padding: const EdgeInsets.only(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      ),
                      child: Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[  
                        Card(
                          elevation: 10,
                          child: Container(  
                            height: 250,
                            width: 5000,
                            decoration: BoxDecoration(  
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(  
                                fit: BoxFit.cover, image: null,
                                //image: NetworkImage(topEvent[0].imageUrl),
                              ),
                            ),
                          ),
                        ),
                
                        RaisedButton(
                              onPressed: () {
                                launchURL(URL);
                              },
                              child: Text(
                                'Buy Tickets',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                ),
                              color: Colors.lightBlue[400],
                            ),
                      ],
                    ),
                  )),
          )
        ]),


          Container(  
            height: 250,
            width: double.infinity,
            child: ListView( 
              scrollDirection: Axis.horizontal,
             // children: widgets.toList(),              
            ),
          ),     

        ],
      ),
        );                          

      
      
  }
}

