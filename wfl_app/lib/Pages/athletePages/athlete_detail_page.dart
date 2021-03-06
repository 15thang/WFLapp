import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:wfl_app/Pages/components/athlete_info_sliver_app_bar.dart';
import 'package:wfl_app/Pages/delegates/sliver_persistent_header_delegate_impl.dart';
import 'athlete_competition_history.dart';
import 'athlete_info_page.dart';

class AthletesDetailPage extends StatefulWidget {
  // Declare a field that holds the Athlete.
  final int athleteId,
      athleteWins,
      athleteLosses,
      athleteDraws,
      athleteYellowcards,
      athleteRedcards;
  final String athleteFullName;

  // In the constructor, require a Athlete.
  AthletesDetailPage(
      {Key key,
      @required this.athleteId,
      this.athleteFullName,
      this.athleteWins,
      this.athleteLosses,
      this.athleteDraws,
      this.athleteYellowcards,
      this.athleteRedcards})
      : super(key: key);

  @override
  _AthletesDetailPageState createState() => _AthletesDetailPageState();
}

class _AthletesDetailPageState extends State<AthletesDetailPage>
    with SingleTickerProviderStateMixin {
  List<Tuple3> _pages;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pages = [
      Tuple3('Info', AthletesInfoPage(athleteID: widget.athleteId),
          widget.athleteFullName),
      Tuple3(
          'Match history',
          AthletesCompPage(
            athleteId: widget.athleteId,
            athleteWins: widget.athleteWins,
            athleteLosses: widget.athleteLosses,
            athleteDraws: widget.athleteDraws,
            athleteYellowcards: widget.athleteYellowcards,
            athleteRedcards: widget.athleteRedcards,
          ),
          widget.athleteFullName),
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
            AthleteSliverAppBar(_pages[_tabController.index].item3),
            SliverPersistentHeader(
              delegate: SliverPersistentHeaderDelegateImpl(
                tabBar: TabBar(
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
