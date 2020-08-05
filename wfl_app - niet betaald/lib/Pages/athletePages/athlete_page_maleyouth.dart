import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:wfl_app/Pages/components/athlete_sliver_app_bar_male_youth.dart';
import 'package:wfl_app/Pages/delegates/sliver_persistent_header_delegate_impl.dart';
import 'athlete_all_gender.dart';
import 'athlete_sorted_weight_gender.dart';

class AthletePageYouthMale extends StatefulWidget {
  AthletePageYouthMale({Key key}) : super(key: key); 

  @override
  _AthletePageYouthMaleState createState() => _AthletePageYouthMaleState();
}

class _AthletePageYouthMaleState extends State<AthletePageYouthMale>
    with SingleTickerProviderStateMixin {
  final List<Tuple3> _pages = [
    Tuple3('All', AllGender(gender: 1, grade: 5), Icon(Icons.image)),
    Tuple3('84', AthleteWeightGender(gender: 1, grade: 5, weight: 3), Icon(Icons.image)),
    Tuple3('77', AthleteWeightGender(gender: 1, grade: 5, weight: 4), Icon(Icons.image)),
    Tuple3('70', AthleteWeightGender(gender: 1, grade: 5, weight: 5), Icon(Icons.image)),
    Tuple3('65', AthleteWeightGender(gender: 1, grade: 5, weight: 6), Icon(Icons.image)),
    Tuple3('61', AthleteWeightGender(gender: 1, grade: 5, weight: 7), Icon(Icons.image)),
    Tuple3('56', AthleteWeightGender(gender: 1, grade: 5, weight: 8), Icon(Icons.image)),
    Tuple3('52', AthleteWeightGender(gender: 1, grade: 5, weight: 9), Icon(Icons.image)),
    Tuple3('48', AthleteWeightGender(gender: 1, grade: 5, weight: 10), Icon(Icons.image)),
    Tuple3('44', AthleteWeightGender(gender: 1, grade: 5, weight: 11), Icon(Icons.image)),
    Tuple3('40', AthleteWeightGender(gender: 1, grade: 5, weight: 12), Icon(Icons.image)),
    Tuple3('36', AthleteWeightGender(gender: 1, grade: 5, weight: 13), Icon(Icons.image)),
    Tuple3('32', AthleteWeightGender(gender: 1, grade: 5, weight: 14), Icon(Icons.image)),
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
