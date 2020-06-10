import 'package:flutter/material.dart';
import 'package:wfl_app/Pages/athletePages/athlete_page_female.dart';
import 'package:wfl_app/Pages/athletePages/athlete_page_femaleyouth.dart';
import 'package:wfl_app/Pages/athletePages/athlete_page_male.dart';
import 'package:wfl_app/Pages/athletePages/athlete_page_maleyouth.dart';

class AthleteDrawer extends StatelessWidget {
  const AthleteDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.grey[900]),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(context),
            _buildFilterMaleItem(context),
            _buildFilterFemaleItem(context),
            _buildFilterMaleYouthItem(context),
            _buildFilterFemaleYouthItem(context),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _buildDrawerHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'http://superfighter.nl/pics/eventpics/event_default1.png'),
        ),
      ),
    );
  }

  ListTile _buildFilterMaleItem(BuildContext context) {
    return ListTile(
      title: Text(
        'Male',
        style: TextStyle(color: Colors.white, fontSize: 23),
      ),
      trailing: Icon(
        Icons.arrow_right,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AthletePageMale(),
          ),
        );
      },
    );
  }

  ListTile _buildFilterFemaleItem(BuildContext context) {
    return ListTile(
      title: Text(
        'Female',
        style: TextStyle(color: Colors.white, fontSize: 23),
      ),
      trailing: Icon(
        Icons.arrow_right,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AthletePageFemale(),
          ),
        );
      },
    );
  }

  ListTile _buildFilterMaleYouthItem(BuildContext context) {
    return ListTile(
      title: Text(
        'Youth Male',
        style: TextStyle(color: Colors.white, fontSize: 23),
      ),
      trailing: Icon(
        Icons.arrow_right,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AthletePageYouthMale(),
          ),
        );
      },
    );
  }

  ListTile _buildFilterFemaleYouthItem(BuildContext context) {
    return ListTile(
      title: Text(
        'Youth Female',
        style: TextStyle(color: Colors.white, fontSize: 23),
      ),
      trailing: Icon(
        Icons.arrow_right,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AthletePageYouthFemale(),
          ),
        );
      },
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.white,
    );
  }
}
