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
      
  final List<Tuple3> _pages = [
    Tuple3('Info', AthletesInfoPage(), Icon(Icons.image)),
    /*Tuple3('Match history', AthletesCompPage(), Icon(Icons.image)),*/
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
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
            AthleteSliverAppBar(_pages[_tabController.index].item1),
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