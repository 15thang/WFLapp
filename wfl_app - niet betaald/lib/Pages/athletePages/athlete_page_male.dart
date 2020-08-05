import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:wfl_app/Pages/components/athlete_sliver_app_bar_male.dart';
import 'package:wfl_app/Pages/delegates/sliver_persistent_header_delegate_impl.dart';
import 'athlete_all_gender.dart';
import 'athlete_sorted_weight_gender.dart';

class AthletePageMale extends StatefulWidget {
  AthletePageMale({Key key}) : super(key: key); 

  @override
  _AthletePageMaleState createState() => _AthletePageMaleState();
}

class _AthletePageMaleState extends State<AthletePageMale>
    with SingleTickerProviderStateMixin {
  final List<Tuple3> _pages = [
    Tuple3('All', AllGender(gender: 1, grade: 4), Icon(Icons.image)),
    Tuple3('95+', AthleteWeightGender(gender: 1, grade: 4, weight: 1), Icon(Icons.image)),
    Tuple3('95', AthleteWeightGender(gender: 1, grade: 4, weight: 2), Icon(Icons.image)),
    Tuple3('84', AthleteWeightGender(gender: 1, grade: 4, weight: 3), Icon(Icons.image)),
    Tuple3('77', AthleteWeightGender(gender: 1, grade: 4, weight: 4), Icon(Icons.image)),
    Tuple3('70', AthleteWeightGender(gender: 1, grade: 4, weight: 5), Icon(Icons.image)),
    Tuple3('65', AthleteWeightGender(gender: 1, grade: 4, weight: 6), Icon(Icons.image)),
    Tuple3('61', AthleteWeightGender(gender: 1, grade: 4, weight: 7), Icon(Icons.image)),
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
