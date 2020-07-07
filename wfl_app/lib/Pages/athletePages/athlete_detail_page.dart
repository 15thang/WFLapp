import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:wfl_app/Pages/components/athlete_info_sliver_app_bar.dart';
import 'package:wfl_app/Pages/delegates/sliver_persistent_header_delegate_impl.dart';
import 'package:wfl_app/model/athletes.dart';
import 'athlete_competition_history.dart';
import 'athlete_info_page.dart';

class AthletesDetailPage extends StatefulWidget {
  // Declare a field that holds the Athlete.
  final Athlete athlete;

  // In the constructor, require a Athlete.
  AthletesDetailPage({Key key, @required this.athlete}) : super(key: key);

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
    var name = widget.athlete.athleteFullName;
        _pages = [
          Tuple3('Info', AthletesInfoPage(athleteID: int.parse(widget.athlete.athleteId)), name.toString()),
      Tuple3('Match history', AthletesCompPage(athlete: widget.athlete), name.toString()),
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
