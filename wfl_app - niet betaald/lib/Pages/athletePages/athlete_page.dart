import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:wfl_app/Pages/components/athlete_sliver_app_bar.dart';
import 'package:wfl_app/Pages/components/athlete_drawer.dart';
import 'package:wfl_app/Pages/delegates/sliver_persistent_header_delegate_impl.dart';
import 'athlete_sorted_weight.dart';
import 'athlete_all.dart';

class AthletePage extends StatefulWidget {
  AthletePage({Key key}) : super(key: key);

  @override
  _AthletePageState createState() => _AthletePageState();
}

class _AthletePageState extends State<AthletePage>
    with SingleTickerProviderStateMixin {
  final List<Tuple3> _pages = [
    Tuple3('All', All(), Icon(Icons.image)),
    Tuple3('95+', W95p(weight: 1), Icon(Icons.image)),
    Tuple3('95', W95p(weight: 2), Icon(Icons.image)),
    Tuple3('84', W95p(weight: 3), Icon(Icons.image)),
    Tuple3('77', W95p(weight: 4), Icon(Icons.image)),
    Tuple3('70', W95p(weight: 5), Icon(Icons.image)),
    Tuple3('65', W95p(weight: 6), Icon(Icons.image)),
    Tuple3('61', W95p(weight: 7), Icon(Icons.image)),
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
      drawer: AthleteDrawer(),
    );
  }
}
