import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wfl_app/Pages/NewsLetter.dart';
import 'package:wfl_app/Pages/competitionPages/competition_page.dart';
import 'package:wfl_app/Pages/morePages/more_page.dart';
import './Pages/HomePage.dart';
import 'Pages/athletePages/athlete_page.dart';
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
        return CompetitionPage();
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
            height: 80,
            child: FutureBuilder<int>(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (int.parse('${snapshot.data}') > 0) {
                      Navigator.of(context).pop();
                      return Text('');
                    } else {
                      return Column(
                        children: <Widget>[
                          Text(
                            'Subcribe to our newsletter',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              'Enter your email adress to receive news and discounts from WFL!')
                        ],
                      );
                    }
                }
              },
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
                Navigator.of(context).pop();
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
