import 'package:flutter/material.dart';

class AthleteSliverAppBar extends StatelessWidget {
  const AthleteSliverAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
    );
  }
}
