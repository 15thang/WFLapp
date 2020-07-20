import 'package:flutter/material.dart';
import 'package:wfl_app/Pages/morePages/more_page.dart';
import './Pages/HomePage.dart';
import 'Pages/athletePages/athlete_page.dart';
import 'Pages/competitionPages/competition_page.dart';
import 'Pages/competitionPages/ongoing_competitionpage.dart';
import 'Pages/eventPages/event_page.dart';
import 'Pages/videoPages/video_live_page.dart';
import 'Pages/morePages/more_page.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedPage = 0;

  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 1:
        return EventPage();
      case 2:
        return AthletePage();
      case 3:
        return YoutubePlayerDemoApp();
      case 4:
        return Competition();
      case 5:
        return MorePage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: callPage(_selectedPage),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(450, 180, 0, 0), Colors.blue])),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (value) {
            _selectedPage = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              title: Text('Event\'s'),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Athletes'),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline),
              title: Text('Video\'s'),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text('Competities'),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              title: Text('More'),
              backgroundColor: Colors.black,
            ),
          ],
        ));
  }

  static color(MaterialColor red) {}

  Widget morepage() {}
}
