import 'package:flutter/material.dart';
import 'package:wfl_app/Pages/NewsLetter.dart';
import 'package:wfl_app/Pages/morePages/more_page.dart';
import './Pages/HomePage.dart';
import 'Pages/athletePages/athlete_page.dart';
import 'Pages/competitionPages/competition_page.dart';
import 'Pages/eventPages/event_page.dart';
import 'Pages/videoPages/video_page.dart';
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
        return Videos();
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
    Future.delayed(Duration.zero, () => showAlert(context));
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

  //melding voor nieuwsbrief
  bool oneAlert = true;
  void showAlert(BuildContext context) {
    if (oneAlert) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 60,
            child: Column(
              children: <Widget>[
                Text("Subscribe to our newsletter",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Voor korting en nieuws van WFL-evenementen.")
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Later"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsLetterPage(),
                  ),
                );
              },
            ),
          ],
        ),
      );
      oneAlert = false;
    }
  }
}
