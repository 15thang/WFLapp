import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wfl_app/model/video.dart';

class VideoPage extends StatelessWidget {
  static String routeName;

  @override
  Widget build(BuildContext context) {
final List<Widget> widgets = List(videoList2.length);
    for (var i = 0; i < videoList2.length; i++) {
      widgets[i] = GestureDetector(
          onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoDetailPage(video: videoList2[i]),
              ),
            );
            print("Container clicked " + i.toString());*/
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
                        height: 200,
                        width: 174,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(videoList2[i].imageURL),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                videoList2[i].title,
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
                                  child: Text(videoList2[i].videoBeschrijving)),
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: widgets.toList(),
        ));
  }
} 