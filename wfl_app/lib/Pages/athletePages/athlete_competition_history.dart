import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:wfl_app/Pages/delegates/sliver_persistent_header_delegate_impl.dart';
import 'athlete_match_history_page.dart';
import 'athlete_upcoming_match_page.dart';

class AthletesCompPage extends StatefulWidget {
  // Declare a field that holds the Athlete.
  final int athleteId,
      athleteWins,
      athleteLosses,
      athleteDraws,
      athleteYellowcards,
      athleteRedcards;

  // In the constructor, require a Athlete.
  AthletesCompPage(
      {Key key,
      @required this.athleteId,
      this.athleteWins,
      this.athleteLosses,
      this.athleteDraws,
      this.athleteYellowcards,
      this.athleteRedcards})
      : super(key: key);

  @override
  _AthletesCompPageState createState() => _AthletesCompPageState();
}

class _AthletesCompPageState extends State<AthletesCompPage>
    with SingleTickerProviderStateMixin {
  List<Tuple3> _pages;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pages = [
      Tuple3(
          'History',
          MatchHistoryPage(
            athleteId: widget.athleteId,
            athleteWins: widget.athleteWins,
            athleteLosses: widget.athleteLosses,
            athleteDraws: widget.athleteDraws,
            athleteYellowcards: widget.athleteYellowcards,
            athleteRedcards: widget.athleteRedcards,
          ),
          Icon(Icons.image)),
      Tuple3('Upcoming matches', UpcomingMatchPage(athleteId: widget.athleteId),
          Icon(Icons.image)),
    ];
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              delegate: SliverPersistentHeaderDelegateImpl(
                tabBar: TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  controller: _tabController,
                  tabs: _pages
                      .map<Tab>((Tuple3 page) => Tab(text: page.item1))
                      .toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _pages.map<Widget>((Tuple3 page) => page.item2).toList(),
        ),
      ),
    );
  }
}
